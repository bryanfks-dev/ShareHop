import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_dev/sqflite_dev.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  tearDown(() async {
    await DatabaseManager.instance.close();
    DatabaseManager.databaseForTesting = null;
    DatabaseManager.enableWorkbench = true;
    DatabaseManager.wipeOnDevMode = true;
    await WorkbenchServer.instance.stop();
  });

  group('DatabaseManager', () {
    test('singleton instance returns identical instance', () {
      final instance1 = DatabaseManager.instance;
      final instance2 = DatabaseManager.instance;

      expect(identical(instance1, instance2), isTrue);
    });

    test('init initializes database and creates schema', () async {
      final db = await DatabaseManager.instance.init(
        filePath: inMemoryDatabasePath,
      );

      expect(db.isOpen, isTrue);

      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table';",
      );
      final tableNames = tables.map((t) => t['name']! as String).toSet();

      expect(tableNames, contains('encrypted_values'));
      expect(tableNames, contains('connections'));
      expect(tableNames, contains('pinned_connections'));
      expect(tableNames, contains('file_transfer_histories'));
    });

    test('init registers database with sqflite_dev workbench', () async {
      await DatabaseManager.instance.init(
        filePath: inMemoryDatabasePath,
      );

      final databases = WorkbenchServer.instance.databases;
      expect(databases.containsKey('sharehop'), isTrue);
      expect(databases['sharehop']?.name, 'ShareHop');

      var attempts = 0;
      while (!WorkbenchServer.instance.isRunning && attempts < 50) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        attempts++;
      }
      expect(WorkbenchServer.instance.isRunning, isTrue);
    });

    test(
      'init does not register with sqflite_dev workbench when '
      'enableWorkbench is false',
      () async {
        await DatabaseManager.instance.init(
          filePath: inMemoryDatabasePath,
          enableWorkbench: false,
        );

        final databases = WorkbenchServer.instance.databases;
        expect(databases.containsKey('sharehop'), isFalse);
        expect(WorkbenchServer.instance.isRunning, isFalse);
      },
    );

    test(
      'init skips workbench server registration gracefully when debug port is '
      'already in use',
      () async {
        final dummySocket =
            await ServerSocket.bind(InternetAddress.anyIPv4, 5554);

        try {
          await DatabaseManager.instance.init(
            filePath: inMemoryDatabasePath,
          );

          expect(WorkbenchServer.instance.isRunning, isFalse);
        } finally {
          await dummySocket.close();
        }
      },
    );

    test('database getter initializes database lazily when not set', () async {
      final db = await DatabaseManager.instance.init(
        filePath: inMemoryDatabasePath,
      );
      final retrievedDb = await DatabaseManager.instance.database;

      expect(retrievedDb, same(db));
      expect(retrievedDb.isOpen, isTrue);
    });

    test(
      'database getter returns databaseForTesting when set',
      () async {
        final db = await openDatabase(inMemoryDatabasePath);
        DatabaseManager.databaseForTesting = db;

        final retrievedDb = await DatabaseManager.instance.database;
        expect(retrievedDb, same(db));

        await DatabaseManager.instance.close();
        await db.close();
      },
    );

    test('close closes database and resets database reference', () async {
      final db = await openDatabase(inMemoryDatabasePath);
      DatabaseManager.databaseForTesting = db;

      await DatabaseManager.instance.close();
      expect(db.isOpen, isFalse);
    });

    test('close does nothing if database is already null', () async {
      DatabaseManager.databaseForTesting = null;

      await expectLater(DatabaseManager.instance.close(), completes);
    });

    test(
      'creates missing tables when opening pre-existing database with '
      'partial schema',
      () async {
        // Simulates an existing database from an older schema version
        // that only had the connections table.
        final legacyDb = await openDatabase(
          inMemoryDatabasePath,
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
              CREATE TABLE connections (
                id TEXT PRIMARY KEY,
                display_name TEXT NOT NULL,
                remote_address TEXT NOT NULL,
                protocol TEXT NOT NULL
              );
            ''');
          },
        );

        final initialTables = await legacyDb.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table';",
        );
        final initialNames =
            initialTables.map((t) => t['name']! as String).toSet();
        expect(initialNames, contains('connections'));
        expect(initialNames, isNot(contains('pinned_connections')));

        // Now run ensureSchemaCreated on it
        await DatabaseManager.instance.ensureSchemaCreated(db: legacyDb);

        final updatedTables = await legacyDb.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table';",
        );
        final updatedNames =
            updatedTables.map((t) => t['name']! as String).toSet();
        expect(updatedNames, contains('connections'));
        expect(updatedNames, contains('pinned_connections'));
        expect(updatedNames, contains('encrypted_values'));
        expect(updatedNames, contains('file_transfer_histories'));

        await legacyDb.close();
      },
    );

    test(
      'wipes out database in dev mode on initialize when filePath is a file '
      'path',
      () async {
        final tempDir = await getDatabasesPath();
        final tempFilePath = '$tempDir/test_dev_wipe.db';

        // Create an existing db file with a legacy table and row
        final rawDb = await openDatabase(
          tempFilePath,
          version: 1,
          onCreate: (db, version) async {
            await db.execute('CREATE TABLE old_data (id INT);');
            await db.execute('INSERT INTO old_data VALUES (42);');
          },
        );
        await rawDb.close();

        DatabaseManager.wipeOnDevMode = true;
        final db = await DatabaseManager.instance.init(filePath: tempFilePath);

        // Verify old table no longer exists and fresh schema tables are present
        final oldTable = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' "
          "AND name='old_data';",
        );
        expect(oldTable, isEmpty);

        final tables = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table';",
        );
        final tableNames = tables.map((t) => t['name']! as String).toSet();
        expect(tableNames, contains('connections'));
        expect(tableNames, contains('encrypted_values'));

        await DatabaseManager.instance.close();
        await deleteDatabase(tempFilePath);
      },
    );

    test('wipeDatabase closes and deletes the database file', () async {
      final tempDir = await getDatabasesPath();
      final tempFilePath = '$tempDir/test_manual_wipe.db';

      final db = await DatabaseManager.instance.init(filePath: tempFilePath);
      expect(db.isOpen, isTrue);

      await DatabaseManager.instance.wipeDatabase(filePath: tempFilePath);
      expect(await databaseExists(tempFilePath), isFalse);
    });
  });
}
