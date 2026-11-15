import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sharehop/infrastructures/repositories/pinned_connection/repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;
  late PinnedConnectionRepositoryImpl repository;

  setUp(() async {
    db = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        final schemaFile = await File('assets/database/schema.sql')
            .readAsString();
        await DatabaseManager.instance.applySchema(
          db: db,
          schemaSql: schemaFile,
        );
      },
    );
    DatabaseManager.databaseForTesting = db;
    repository = const PinnedConnectionRepositoryImpl();
  });

  tearDown(() async {
    await db.close();
    DatabaseManager.databaseForTesting = null;
  });

  group('PinnedConnectionRepositoryImpl', () {
    test('pin inserts connection into pinned_connections table', () async {
      final connectionId = const Uuid().v7obj();

      await repository.pin(connectionId);

      final rows = await db.query(
        PinnedConnectionModel.tableName,
        where: 'connection_id = ?',
        whereArgs: [connectionId.uuid],
      );

      expect(rows.length, 1);
      expect(rows.first['connection_id'], connectionId.uuid);
    });

    test('unpin deletes connection from pinned_connections table', () async {
      final connectionId = const Uuid().v7obj();

      await repository.pin(connectionId);
      expect(await repository.getPinnedConnectionIds(), {connectionId});

      await repository.unpin(connectionId);
      expect(await repository.getPinnedConnectionIds(), isEmpty);
    });

    test('getPinnedConnectionIds returns all pinned connection IDs', () async {
      final first = const Uuid().v7obj();
      final second = const Uuid().v7obj();

      await repository.pin(first);
      await repository.pin(second);

      final ids = await repository.getPinnedConnectionIds();
      expect(ids, {first, second});
    });

    test('getAll returns all PinnedConnectionModel entries', () async {
      final id = const Uuid().v7obj();

      await repository.pin(id);

      final all = await repository.getAll();
      expect(all.length, 1);
      expect(all.first.connectionId, id);
    });
  });
}
