import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/data/dto/storage_status_dto.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:sharehop/core/repositories/connection/repository.dart';
import 'package:sharehop/core/gateways/web_dav_storage_gateway.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/core/use_cases/test_connection_use_case.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/infrastructures/repositories/connection/factory.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';
import 'package:sharehop/presentation/controllers/connection_controller.dart';
import 'package:webdav_client/webdav_client.dart';

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
  }) async =>
      [];

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
  }) async =>
      Uint8List(0);

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
  }) async =>
      throw UnimplementedError();

  @override
  Future<StorageStatusDto> getStatus({
    required WebDavCredentialModel credential,
    String path = '/',
  }) async =>
      const StorageStatusDto(
        totalBytes: 500 * 1024 * 1024 * 1024,
        freeBytes: 64 * 1024 * 1024 * 1024,
      );
}

class FakeConnectionRepository implements ConnectionRepository {
  final List<ConnectionModel> connections = [];

  @override
  Future<List<ConnectionModel>> getAll() async => connections;

  @override
  Future<ConnectionModel> create(ConnectionDraftDto draft) async {
    final connection = buildConnectionDraftDtoFromConnectionModel(draft);
    connections.add(connection);
    return connection;
  }

  @override
  Future<ConnectionModel?> getOne(String id) async => null;

  @override
  Future<ConnectionModel?> update(ConnectionRevisionDto revision) async => null;

  @override
  Future<void> remove(String id) async {}

  @override
  Future<void> batchRemove(Set<String> ids) async {}

  @override
  Future<String?> checkIfExists(String id) async => null;
}

void main() {
  group('ConnectionController', () {
    test('successfully tests and saves WebDAV connection', () async {
      final fakeService = FakeWebDavStorageGateway();
      final fakeRepo = FakeConnectionRepository();

      final controller = ProviderContainer(
        overrides: [
          testConnectionUseCaseProvider.overrideWithValue(
            TestConnectionUseCase(fakeService),
          ),
          createConnectionUseCaseProvider.overrideWithValue(
            CreateConnectionUseCase(fakeRepo),
          ),
        ],
      );

      final result = await controller
          .read(connectionControllerProvider.notifier)
          .addWebDavConnection(
            serverUrl: 'https://example.com/dav',
            rootPath: '/',
            username: 'admin',
            password: 'secretpassword',
            displayName: 'My Cloud',
          );

      expect(result.displayName, 'My Cloud');
      expect(result.remoteAddress, 'https://example.com/dav');
      expect(result.protocol, ConnectionProtocol.webdav);
      expect(fakeRepo.connections.length, 1);
      expect(
        fakeService.passedCredential?.url,
        Uri.parse('https://example.com/dav'),
      );
      expect(fakeService.passedCredential?.username, 'admin');
      expect(fakeService.passedCredential?.password, 'secretpassword');

      final state = controller.read(connectionControllerProvider);
      expect(state.value?.id, result.id);
    });

    test('rethrows error and updates state when connection test fails',
        () async {
      final fakeService = FakeWebDavStorageGateway()..shouldThrow = true;
      final fakeRepo = FakeConnectionRepository();

      final controller = ProviderContainer(
        overrides: [
          testConnectionUseCaseProvider.overrideWithValue(
            TestConnectionUseCase(fakeService),
          ),
          createConnectionUseCaseProvider.overrideWithValue(
            CreateConnectionUseCase(fakeRepo),
          ),
        ],
      );

      await expectLater(
        controller
            .read(connectionControllerProvider.notifier)
            .addWebDavConnection(
              serverUrl: 'https://example.com/dav',
              rootPath: '/',
              username: 'admin',
              password: 'wrongpassword',
            ),
        throwsA(isA<WebDavOperationFailedError>()),
      );

      expect(fakeRepo.connections, isEmpty);
      final state = controller.read(connectionControllerProvider);
      expect(state.hasError, isTrue);
    });
  });
}
