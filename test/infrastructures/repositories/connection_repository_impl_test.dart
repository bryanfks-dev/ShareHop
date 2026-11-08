import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/errors/connection.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/data/utils/not_required_value.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
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
        final schemaFile = await File('assets/database/schema.sql')
            .readAsString();
        await DatabaseManager.instance.applySchema(
          db: db,
          schemaSql: schemaFile,
        );
      },
    );
    DatabaseManager.databaseForTesting = db;
    repository = ConnectionRepositoryImpl(
      connectionMapper: ConnectionMapper(EncryptedValueMapper()),
    );
  });

  tearDown(() async {
    await db.close();
    DatabaseManager.databaseForTesting = null;
  });

  group('ConnectionRepositoryImpl.create', () {
    test('creates and saves connection into SQLite table', () async {
      const draft = ConnectionDraftDto(
        protocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://dav.example.com',
        displayName: 'My WebDAV Server',
        username: 'admin',
        password: 'secret_password',
      );

      final created = await repository.create(connection: draft);

      expect(created.id, isNotEmpty);
      expect(created.displayName, 'My WebDAV Server');
      expect(created.remoteAddress, 'https://dav.example.com');
      expect(created.protocol, ConnectionProtocol.webdav);
      expect(created.username, 'admin');

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
      expect(row['username'], 'admin');
      expect(row['protocol'], 'webdav');
      expect(row['created_at'], isNotNull);
      expect(row['updated_at'], isNotNull);
    });

    test(
      'throws CreateConnectionFailedError when SQLite insert fails',
      () async {
        await db.close();

        const draft = ConnectionDraftDto(
          protocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://fail.example.com',
          displayName: 'Fail',
          username: 'admin',
          password: 'pass',
        );

        expect(
          () => repository.create(connection: draft),
          throwsA(isA<CreateConnectionFailedError>()),
        );
      },
    );
  });

  group('ConnectionRepositoryImpl CRUD queries', () {
    test('getAll returns saved connections from SQLite table', () async {
      expect(await repository.getAll(), isEmpty);

      final first = await repository.create(
        connection: const ConnectionDraftDto(
          protocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://first.com',
          displayName: 'First',
          username: 'user1',
          password: 'pwd',
        ),
      );

      final second = await repository.create(
        connection: const ConnectionDraftDto(
          protocol: ConnectionProtocol.sftp,
          remoteAddress: 'sftp://second.com',
          displayName: 'Second',
          username: 'user2',
          password: 'pwd',
        ),
      );

      final all = await repository.getAll();
      expect(all.length, 2);
      expect(all.any((c) => c.id == first.id), isTrue);
      expect(all.any((c) => c.id == second.id), isTrue);
      expect(
        all.firstWhere((c) => c.id == first.id).password?.cipherText,
        'pwd',
      );
      expect(
        all.firstWhere((c) => c.id == first.id).password?.id,
        first.password?.id,
      );
    });

    test('getOne retrieves specific connection from SQLite table', () async {
      final created = await repository.create(
        connection: const ConnectionDraftDto(
          protocol: ConnectionProtocol.ftp,
          remoteAddress: 'ftp://example.com',
          displayName: 'FTP Storage',
          username: 'ftpuser',
          password: 'pwd',
        ),
      );

      final fetched = await repository.getOne(id: created.id);
      expect(fetched, isNotNull);
      expect(fetched?.id, created.id);
      expect(fetched?.displayName, 'FTP Storage');
      expect(fetched?.password?.id, created.password?.id);
      expect(fetched?.password?.cipherText, 'pwd');

      final nonExistent = await repository.getOne(id: 'non-existent-id');
      expect(nonExistent, isNull);
    });

    test(
      'update modifies existing connection in SQLite table with partial fields',
      () async {
      final created = await repository.create(
        connection: const ConnectionDraftDto(
          protocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://old.example.com',
          displayName: 'Old Name',
          username: 'admin',
          password: 'pwd',
        ),
      );

      final updated = await repository.update(
        connection: ConnectionRevisionDto(
          id: created.id,
          displayName: const NotRequiredValue('Updated Name'),
          remoteAddress: const NotRequiredValue('https://new.example.com'),
        ),
      );

      expect(updated, isNotNull);
      expect(updated?.displayName, 'Updated Name');
      expect(updated?.remoteAddress, 'https://new.example.com');
      expect(updated?.username, 'admin');
      expect(updated?.protocol, ConnectionProtocol.webdav);
      expect(updated?.password?.cipherText, 'pwd');

      final row = (await db.query(
        ConnectionModel.tableName,
        where: 'id = ?',
        whereArgs: [created.id],
      )).first;

      expect(row['display_name'], 'Updated Name');
      expect(row['remote_address'], 'https://new.example.com');
      expect(row['username'], 'admin');
      expect(row['protocol'], 'webdav');
    });

    test(
      'update updates password when provided via NotRequiredValue',
      () async {
      final created = await repository.create(
        connection: const ConnectionDraftDto(
          protocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://webdav.example.com',
          displayName: 'WebDAV Server',
          username: 'admin',
          password: 'old_password',
        ),
      );

      final updated = await repository.update(
        connection: ConnectionRevisionDto(
          id: created.id,
          password: const NotRequiredValue('new_secret_password'),
        ),
      );

      expect(updated, isNotNull);
      expect(updated?.displayName, 'WebDAV Server');
      expect(updated?.password?.cipherText, 'new_secret_password');
    });

    test('update returns null if connection does not exist', () async {
      final updated = await repository.update(
        connection: const ConnectionRevisionDto(
          id: 'non-existent-id',
          displayName: NotRequiredValue('New Name'),
        ),
      );

      expect(updated, isNull);
    });

    test('checkIfExists returns id if connection exists', () async {
      final created = await repository.create(
        connection: const ConnectionDraftDto(
          protocol: ConnectionProtocol.nfs,
          remoteAddress: 'nfs://share',
          displayName: 'NFS Share',
          username: 'nfs',
          password: 'pwd',
        ),
      );

      expect(await repository.checkIfExists(id: created.id), created.id);
      expect(await repository.checkIfExists(id: 'unknown-id'), isNull);
    });

    test('remove deletes connection from SQLite table', () async {
      final created = await repository.create(
        connection: const ConnectionDraftDto(
          protocol: ConnectionProtocol.ftps,
          remoteAddress: 'ftps://secure.com',
          displayName: 'FTPS',
          username: 'user',
          password: 'pwd',
        ),
      );

      await repository.remove(id: created.id);

      final found = await repository.getOne(id: created.id);
      expect(found, isNull);
    });

    test(
      'batchRemove deletes multiple connections from SQLite table',
      () async {
        final first = await repository.create(
          connection: const ConnectionDraftDto(
            protocol: ConnectionProtocol.webdav,
            remoteAddress: 'https://1.com',
            displayName: 'First',
            username: 'u1',
            password: 'pwd',
          ),
        );
        final second = await repository.create(
          connection: const ConnectionDraftDto(
            protocol: ConnectionProtocol.webdav,
            remoteAddress: 'https://2.com',
            displayName: 'Second',
            username: 'u2',
            password: 'pwd',
          ),
        );

        await repository.batchRemove(ids: {first.id, second.id});

        expect(await repository.getAll(), isEmpty);
      },
    );
  });
}
