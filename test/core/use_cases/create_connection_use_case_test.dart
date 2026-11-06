import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_credential_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/gateways/web_dav_storage_gateway.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';
import 'package:webdav_client/webdav_client.dart';

class FakeConnectionRepository implements ConnectionRepository {
  final List<ConnectionModel> connections = [];

  @override
  Future<ConnectionModel> create(ConnectionDraftDto draft) async {
    final model = buildConnectionDraftDtoFromConnectionModel(draft);
    connections.add(model);
    return model;
  }

  @override
  Future<List<ConnectionModel>> getAll() async => connections;

  @override
  Future<ConnectionModel?> getOne(String id) async {
    for (final connection in connections) {
      if (connection.id == id) {
        return connection;
      }
    }
    return null;
  }

  @override
  Future<ConnectionModel?> update(ConnectionRevisionDto revision) async => null;

  @override
  Future<void> remove(String id) async {
    connections.removeWhere((c) => c.id == id);
  }

  @override
  Future<void> batchRemove(Set<String> ids) async {
    connections.removeWhere((c) => ids.contains(c.id));
  }

  @override
  Future<String?> checkIfExists(String id) async =>
      connections.any((c) => c.id == id) ? id : null;
}

class FakeWebDavStorageGateway implements WebDavStorageGateway {
  bool shouldThrow = false;
  WebDavCredentialModel? passedCredential;

  @override
  Future<void> testConnection({
    required WebDavCredentialModel credential,
  }) async {
    passedCredential = credential;
    if (shouldThrow) {
      throw WebDavOperationFailedError('Failed to connect to WebDAV server');
    }
  }

  @override
  Future<List<File>> list({
    required WebDavCredentialModel credential,
    required String path,
  }) async => [];

  @override
  Future<void> createDirectory({
    required WebDavCredentialModel credential,
    required String path,
  }) async {}

  @override
  Future<void> delete({
    required WebDavCredentialModel credential,
    required String path,
  }) async {}

  @override
  Future<void> uploadFile({
    required WebDavCredentialModel credential,
    required String path,
    required Uint8List fileBytes,
  }) async {}

  @override
  Future<Uint8List> downloadFile({
    required WebDavCredentialModel credential,
    required String path,
  }) async => Uint8List(0);

  @override
  Future<void> rename({
    required WebDavCredentialModel credential,
    required String oldPath,
    required String newPath,
  }) async {}

  @override
  Future<void> copy({
    required WebDavCredentialModel credential,
    required String sourcePath,
    required String destinationPath,
  }) async {}

  @override
  Future<void> move({
    required WebDavCredentialModel credential,
    required String sourcePath,
    required String destinationPath,
  }) async {}

  @override
  Future<File> getFileProperties({
    required WebDavCredentialModel credential,
    required String path,
  }) async => throw UnimplementedError();

  @override
  Future<StorageStatusDto> getStatus({
    required WebDavCredentialModel credential,
    String path = '/',
  }) async => const StorageStatusDto(
    totalBytes: 500 * 1024 * 1024 * 1024,
    freeBytes: 64 * 1024 * 1024 * 1024,
  );
}

class FakeUnsupportedCredentialModel implements ConnectionCredentialModel {
  const new(this.protocol);

  @override
  final ConnectionProtocol protocol;
}

void main() {
  group('CreateConnectionUseCase', () {
    test(
      'creates and persists connection from draft without credential',
      () async {
        final fakeRepo = FakeConnectionRepository();
        final useCase = CreateConnectionUseCase(fakeRepo);

        const draft = ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://example.com/dav',
          displayName: 'My WebDAV',
        );

        final result = await useCase.call(draft: draft);

        expect(result.displayName, 'My WebDAV');
        expect(result.protocol, ConnectionProtocol.webdav);
        expect(result.remoteAddress, 'https://example.com/dav');
        expect(fakeRepo.connections.length, 1);
        expect(fakeRepo.connections.first.id, result.id);
      },
    );

    test('tests connection successfully before creating connection', () async {
      final fakeRepo = FakeConnectionRepository();
      final fakeStorageService = FakeWebDavStorageGateway();
      final testConnectionUseCase = TestConnectionUseCase(fakeStorageService);
      final useCase = CreateConnectionUseCase(fakeRepo, testConnectionUseCase);

      const draft = ConnectionDraftDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://example.com/dav',
        displayName: 'Tested WebDAV',
      );
      final credential = WebDavCredentialModel(
        url: Uri.parse('https://example.com/dav'),
        username: 'admin',
        password: 'password',
      );

      final result = await useCase.call(draft: draft, credential: credential);

      expect(result.displayName, 'Tested WebDAV');
      expect(fakeStorageService.passedCredential, credential);
      expect(fakeRepo.connections.length, 1);
    });

    test(
      'does not create connection and rethrows when test connection fails',
      () async {
        final fakeRepo = FakeConnectionRepository();
        final fakeStorageService = FakeWebDavStorageGateway()
          ..shouldThrow = true;
        final testConnectionUseCase = TestConnectionUseCase(fakeStorageService);
        final useCase = CreateConnectionUseCase(
          fakeRepo,
          testConnectionUseCase,
        );

        const draft = ConnectionDraftDto(
          connectionProtocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://example.com/dav',
        );
        final credential = WebDavCredentialModel(
          url: Uri.parse('https://example.com/dav'),
          username: 'admin',
          password: 'wrong_password',
        );

        expect(
          () => useCase.call(draft: draft, credential: credential),
          throwsA(isA<WebDavOperationFailedError>()),
        );
        expect(fakeRepo.connections, isEmpty);
      },
    );

    test('accepts any connection protocol even when test connection is '
        'unimplemented', () async {
      final fakeRepo = FakeConnectionRepository();
      final fakeStorageService = FakeWebDavStorageGateway();
      final testConnectionUseCase = TestConnectionUseCase(fakeStorageService);
      final useCase = CreateConnectionUseCase(fakeRepo, testConnectionUseCase);

      for (final protocol in ConnectionProtocol.values) {
        final draft = ConnectionDraftDto(
          connectionProtocol: protocol,
          remoteAddress: '192.168.1.100',
          displayName: '${protocol.name} Server',
        );
        final credential = FakeUnsupportedCredentialModel(protocol);

        final result = await useCase.call(draft: draft, credential: credential);

        expect(result.protocol, protocol);
        expect(result.displayName, '${protocol.name} Server');
      }

      expect(fakeRepo.connections.length, ConnectionProtocol.values.length);
    });

    test('accepts any connection protocol when credential is null', () async {
      final fakeRepo = FakeConnectionRepository();
      final fakeStorageService = FakeWebDavStorageGateway();
      final testConnectionUseCase = TestConnectionUseCase(fakeStorageService);
      final useCase = CreateConnectionUseCase(fakeRepo, testConnectionUseCase);

      for (final protocol in ConnectionProtocol.values) {
        final draft = ConnectionDraftDto(
          connectionProtocol: protocol,
          remoteAddress: '10.0.0.1',
          displayName: 'Remote ${protocol.name}',
        );

        final result = await useCase.call(draft: draft);

        expect(result.protocol, protocol);
      }

      expect(fakeRepo.connections.length, ConnectionProtocol.values.length);
    });
  });
}
