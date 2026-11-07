import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  tearDown(() async {
    DatabaseManager.databaseForTesting = null;
  });

  group('DatabaseManager', () {
    test('singleton instance returns identical instance', () {
      final instance1 = DatabaseManager.instance;
      final instance2 = DatabaseManager.instance;

      expect(identical(instance1, instance2), isTrue);
    });

    test('database getter returns databaseForTesting when set', () async {
      final db = await openDatabase(inMemoryDatabasePath);
      DatabaseManager.databaseForTesting = db;

      final retrievedDb = await DatabaseManager.instance.database;
      expect(retrievedDb, same(db));

      await DatabaseManager.instance.close();
      await db.close();
    });

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
  });
}
