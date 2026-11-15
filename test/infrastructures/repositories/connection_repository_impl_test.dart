import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/errors/connection.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/data/utils/not_required_value.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sharehop/infrastructures/repositories/connection/repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;
  late ConnectionRepositoryImpl repository;

  ConnectionModel createTestModel({
    UuidValue? id,
    ConnectionProtocol protocol = ConnectionProtocol.webdav,
    String displayName = 'My Server',
    String remoteAddress = 'https://dav.example.com',
    String username = 'admin',
    String passwordCipherText = 'secret_password',
    String rootPath = '/',
    bool allowSelfSignedCertificate = false,
  }) {
    final now = DateTime.now().toUtc();
    final passwordId = const Uuid().v7obj();
    final password = EncryptedValueModel(
      id: passwordId,
      salt: 'salt',
      nonce: 'nonce',
      cipherText: passwordCipherText,
      mac: 'mac',
      createdAt: now,
      updatedAt: now,
    );
    return ConnectionModel(
      id: id ?? const Uuid().v7obj(),
      protocol: protocol,
      displayName: displayName,
      remoteAddress: remoteAddress,
      username: username,
      passwordId: passwordId,
      password: password,
      rootPath: rootPath,
      allowSelfSignedCertificate: allowSelfSignedCertificate,
      createdAt: now,
      updatedAt: now,
    );
  }

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
    repository = const ConnectionRepositoryImpl(
      connectionMapper: ConnectionMapper(EncryptedValueMapper()),
    );
  });

  tearDown(() async {
    await db.close();
    DatabaseManager.databaseForTesting = null;
  });

  group('ConnectionRepositoryImpl.create', () {
    test('creates and saves connection into SQLite table', () async {
      final model = createTestModel(
        displayName: 'My WebDAV Server',
      );

      final created = await repository.create(model);

      expect(created.id, model.id);
      expect(created.displayName, 'My WebDAV Server');
      expect(created.remoteAddress, 'https://dav.example.com');
      expect(created.protocol, ConnectionProtocol.webdav);
      expect(created.username, 'admin');

      final rows = await db.query(
        ConnectionModel.tableName,
        where: 'id = ?',
        whereArgs: [created.id.uuid],
      );

      expect(rows.length, 1);
      final row = rows.first;
      expect(row['id'], created.id.uuid);
      expect(row['display_name'], 'My WebDAV Server');
      expect(row['remote_address'], 'https://dav.example.com');
      expect(row['username'], 'admin');
      expect(row['protocol'], 'webdav');
      expect(row['created_at'], isNotNull);
      expect(row['updated_at'], isNotNull);

      final pwRows = await db.query(
        EncryptedValueModel.tableName,
        where: 'id = ?',
        whereArgs: [created.passwordId.uuid],
      );
      expect(pwRows.length, 1);
      expect(pwRows.first['cipher_text'], 'secret_password');
    });

    test(
      'throws CreateConnectionFailedError when SQLite insert fails',
      () async {
        await db.close();

        final model = createTestModel();

        expect(
          () => repository.create(model),
          throwsA(isA<CreateConnectionFailedError>()),
        );
      },
    );
  });

  group('ConnectionRepositoryImpl CRUD queries', () {
    test('getAll returns saved connections from SQLite table', () async {
      expect(await repository.getAll(), isEmpty);

      final first = await repository.create(
        createTestModel(
          remoteAddress: 'https://first.com',
          displayName: 'First',
          username: 'user1',
          passwordCipherText: 'pwd1',
        ),
      );

      final second = await repository.create(
        createTestModel(
          protocol: ConnectionProtocol.sftp,
          remoteAddress: 'sftp://second.com',
          displayName: 'Second',
          username: 'user2',
          passwordCipherText: 'pwd2',
        ),
      );

      final all = await repository.getAll();
      expect(all.length, 2);
      expect(all.any((c) => c.id == first.id), isTrue);
      expect(all.any((c) => c.id == second.id), isTrue);
      expect(
        all.firstWhere((c) => c.id == first.id).password?.cipherText,
        'pwd1',
      );
      expect(
        all.firstWhere((c) => c.id == first.id).password?.id,
        first.password?.id,
      );
    });

    test('getOne retrieves specific connection from SQLite table', () async {
      final created = await repository.create(
        createTestModel(
          protocol: ConnectionProtocol.ftp,
          remoteAddress: 'ftp://example.com',
          displayName: 'FTP Storage',
          username: 'ftpuser',
          passwordCipherText: 'pwd',
        ),
      );

      final fetched = await repository.getOne(created.id);
      expect(fetched, isNotNull);
      expect(fetched?.id, created.id);
      expect(fetched?.displayName, 'FTP Storage');
      expect(fetched?.password?.id, created.password?.id);
      expect(fetched?.password?.cipherText, 'pwd');

      final nonExistent = await repository.getOne(const Uuid().v7obj());
      expect(nonExistent, isNull);
    });

    test(
      'update modifies existing connection in SQLite table with partial fields',
      () async {
        final created = await repository.create(
          createTestModel(
            remoteAddress: 'https://old.example.com',
            displayName: 'Old Name',
            passwordCipherText: 'pwd',
          ),
        );

        final updated = await repository.update(
          connection: ConnectionRevisionDto(
            id: created.id.uuid,
            displayName: const NotRequiredValue('Updated Name'),
            remoteAddress: const NotRequiredValue('https://new.example.com'),
            allowSelfSignedCertificate: const NotRequiredValue(true),
          ),
        );

        expect(updated, isNotNull);
        expect(updated?.displayName, 'Updated Name');
        expect(updated?.remoteAddress, 'https://new.example.com');
        expect(updated?.username, 'admin');
        expect(updated?.protocol, ConnectionProtocol.webdav);
        expect(updated?.allowSelfSignedCertificate, isTrue);
        expect(updated?.password?.cipherText, 'pwd');

        final row = (await db.query(
          ConnectionModel.tableName,
          where: 'id = ?',
          whereArgs: [created.id.uuid],
        )).first;

        expect(row['display_name'], 'Updated Name');
        expect(row['remote_address'], 'https://new.example.com');
        expect(row['username'], 'admin');
        expect(row['protocol'], 'webdav');
        expect(row['allow_self_signed_certificate'], 1);
      },
    );

    test(
      'update updates password when provided via NotRequiredValue',
      () async {
        final created = await repository.create(
          createTestModel(
            remoteAddress: 'https://webdav.example.com',
            displayName: 'WebDAV Server',
            passwordCipherText: 'old_password',
          ),
        );

        final updated = await repository.update(
          connection: ConnectionRevisionDto(
            id: created.id.uuid,
            password: const NotRequiredValue('new_secret_password'),
          ),
        );

        expect(updated, isNotNull);
        expect(updated?.displayName, 'WebDAV Server');
        expect(updated?.password?.cipherText, 'new_secret_password');
      },
    );

    test('update returns null if connection does not exist', () async {
      final updated = await repository.update(
        connection: ConnectionRevisionDto(
          id: const Uuid().v7obj().uuid,
          displayName: const NotRequiredValue('New Name'),
        ),
      );

      expect(updated, isNull);
    });

    test('checkIfExists returns set of existing ids', () async {
      final first = await repository.create(
        createTestModel(
          protocol: ConnectionProtocol.nfs,
          remoteAddress: 'nfs://share1',
          displayName: 'NFS Share 1',
        ),
      );
      final second = await repository.create(
        createTestModel(
          protocol: ConnectionProtocol.nfs,
          remoteAddress: 'nfs://share2',
          displayName: 'NFS Share 2',
        ),
      );
      final unknownId = const Uuid().v7obj();

      final existing = await repository.checkIfExists(
        {first.id, second.id, unknownId},
      );
      expect(existing, {first.id, second.id});
      expect(existing.contains(unknownId), isFalse);

      expect(await repository.checkIfExists({}), isEmpty);
    });

    test('remove deletes connection from SQLite table', () async {
      final created = await repository.create(
        createTestModel(
          protocol: ConnectionProtocol.ftps,
          remoteAddress: 'ftps://secure.com',
          displayName: 'FTPS',
          username: 'user',
          passwordCipherText: 'pwd',
        ),
      );

      await repository.remove(created.id);

      final found = await repository.getOne(created.id);
      expect(found, isNull);

      final pwRow = await db.query(
        EncryptedValueModel.tableName,
        where: 'id = ?',
        whereArgs: [created.passwordId.uuid],
      );
      expect(pwRow, isEmpty);
    });

    test(
      'batchRemove deletes multiple connections from SQLite table',
      () async {
        final first = await repository.create(
          createTestModel(
            remoteAddress: 'https://1.com',
            displayName: 'First',
          ),
        );
        final second = await repository.create(
          createTestModel(
            remoteAddress: 'https://2.com',
            displayName: 'Second',
          ),
        );

        await repository.batchRemove({first.id, second.id});

        expect(await repository.getAll(), isEmpty);
      },
    );
  });
}
