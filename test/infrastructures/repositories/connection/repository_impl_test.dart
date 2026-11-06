import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sharehop/infrastructures/repositories/connection/error.dart';
import 'package:sharehop/infrastructures/repositories/connection/repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;
  late ConnectionRepositoryImpl repository;

  setUp(() async {
    db = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        final schemaFile =
            await File('assets/database/schema.sql').readAsString();
        await DatabaseManager.applySchema(db, schemaFile);
      },
    );
    DatabaseManager.databaseForTesting = db;
    repository = const ConnectionRepositoryImpl();
  });

  tearDown(() async {
    await db.close();
    DatabaseManager.databaseForTesting = null;
  });

  group('ConnectionRepositoryImpl.create', () {
    test('creates and saves connection into SQLite table', () async {
      const draft = ConnectionDraftDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://dav.example.com',
        displayName: 'My WebDAV Server',
      );

      final created = await repository.create(draft);

      expect(created.id, isNotEmpty);
      expect(created.displayName, 'My WebDAV Server');
      expect(created.remoteAddress, 'https://dav.example.com');
      expect(created.protocol, ConnectionProtocol.webdav);
      expect(created.status, ConnectionStatus.online);

      final rows = await db.query(
        ConnectionModel.tableName,
        where: 'id = ?',
        whereArgs: [created.id],
      );

      expect(rows.length, 1);
      final row = rows.first;
      expect(row['id'], created.id);
      expect(row['display_name'], 'My WebDAV Server');
      expect(row['remote_address'], 'https://dav.example.com');
      expect(row['protocol'], 'webdav');
      expect(row['status'], 'online');
      expect(row['created_at'], isNotNull);
      expect(row['updated_at'], isNotNull);
    });

    test('falls back to remoteAddress when displayName is null or empty',
        () async {
      const draft = ConnectionDraftDto(
        connectionProtocol: ConnectionProtocol.smb,
        remoteAddress: 'smb://192.168.1.100',
        displayName: '   ',
      );

      final created = await repository.create(draft);

      expect(created.displayName, 'smb://192.168.1.100');

      final rows = await db.query(
        ConnectionModel.tableName,
        where: 'id = ?',
        whereArgs: [created.id],
      );
      expect(rows.first['display_name'], 'smb://192.168.1.100');
    });

    test('throws CreateConnectionFailedError when SQLite insert fails',
        () async {
      await db.close();

      const draft = ConnectionDraftDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://fail.example.com',
      );

      expect(
        () => repository.create(draft),
        throwsA(isA<CreateConnectionFailedError>()),
      );
    });
  });

  group('ConnectionRepositoryImpl CRUD queries', () {
    test('getAll returns saved connections from SQLite table', () async {
      expect(await repository.getAll(), isEmpty);

      final first = await repository.create(
        const ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://first.com',
          displayName: 'First',
        ),
      );

      final second = await repository.create(
        const ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.sftp,
          remoteAddress: 'sftp://second.com',
          displayName: 'Second',
        ),
      );

      final all = await repository.getAll();
      expect(all.length, 2);
      expect(all.any((c) => c.id == first.id), isTrue);
      expect(all.any((c) => c.id == second.id), isTrue);
    });

    test('getOne retrieves specific connection from SQLite table', () async {
      final created = await repository.create(
        const ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.ftp,
          remoteAddress: 'ftp://example.com',
          displayName: 'FTP Storage',
        ),
      );

      final fetched = await repository.getOne(created.id);
      expect(fetched, isNotNull);
      expect(fetched?.id, created.id);
      expect(fetched?.displayName, 'FTP Storage');

      final nonExistent = await repository.getOne('non-existent-id');
      expect(nonExistent, isNull);
    });

    test('update modifies existing connection in SQLite table', () async {
      final created = await repository.create(
        const ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://old.example.com',
          displayName: 'Old Name',
        ),
      );

      final updated = await repository.update(
        ConnectionRevisionDto(
          id: created.id,
          displayName: 'Updated Name',
          remoteAddress: 'https://new.example.com',
        ),
      );

      expect(updated, isNotNull);
      expect(updated?.displayName, 'Updated Name');
      expect(updated?.remoteAddress, 'https://new.example.com');

      final row = (await db.query(
        ConnectionModel.tableName,
        where: 'id = ?',
        whereArgs: [created.id],
      )).first;

      expect(row['display_name'], 'Updated Name');
      expect(row['remote_address'], 'https://new.example.com');
    });

    test('checkIfExists returns id if connection exists', () async {
      final created = await repository.create(
        const ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.nfs,
          remoteAddress: 'nfs://share',
        ),
      );

      expect(await repository.checkIfExists(created.id), created.id);
      expect(await repository.checkIfExists('unknown-id'), isNull);
    });

    test('remove deletes connection from SQLite table', () async {
      final created = await repository.create(
        const ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.ftps,
          remoteAddress: 'ftps://secure.com',
        ),
      );

      await repository.remove(created.id);

      final found = await repository.getOne(created.id);
      expect(found, isNull);
    });

    test('batchRemove deletes multiple connections from SQLite table',
        () async {
      final first = await repository.create(
        const ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://1.com',
        ),
      );
      final second = await repository.create(
        const ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://2.com',
        ),
      );

      await repository.batchRemove({first.id, second.id});

      expect(await repository.getAll(), isEmpty);
    });
  });
}
