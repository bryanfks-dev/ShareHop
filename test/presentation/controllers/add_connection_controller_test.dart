import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:sharehop/core/repositories/connection/repository.dart';
import 'package:sharehop/core/services/web_dav_storage_service.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/core/use_cases/test_web_dav_connection_use_case.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/infrastructures/repositories/connection/factory.dart';
import 'package:sharehop/infrastructures/services/web_dav_storage/error.dart';
import 'package:sharehop/presentation/controllers/add_connection_controller.dart';
import 'package:webdav_client/webdav_client.dart';

class FakeWebDavStorageService implements WebDavStorageService {
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
}

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
  group('AddConnectionController', () {
    test('successfully tests and saves WebDAV connection', () async {
      final fakeService = FakeWebDavStorageService();
      final fakeRepo = FakeConnectionRepository();

      final controller = ProviderContainer(
        overrides: [
          testWebDavConnectionUseCaseProvider.overrideWithValue(
            TestWebDavConnectionUseCase(fakeService),
          ),
          createConnectionUseCaseProvider.overrideWithValue(
            CreateConnectionUseCase(fakeRepo),
          ),
        ],
      );

      final result = await controller
          .read(addConnectionControllerProvider.notifier)
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

      final state = controller.read(addConnectionControllerProvider);
      expect(state.value?.id, result.id);
    });

    test('rethrows error and updates state when connection test fails',
        () async {
      final fakeService = FakeWebDavStorageService()..shouldThrow = true;
      final fakeRepo = FakeConnectionRepository();

      final controller = ProviderContainer(
        overrides: [
          testWebDavConnectionUseCaseProvider.overrideWithValue(
            TestWebDavConnectionUseCase(fakeService),
          ),
          createConnectionUseCaseProvider.overrideWithValue(
            CreateConnectionUseCase(fakeRepo),
          ),
        ],
      );

      await expectLater(
        controller
            .read(addConnectionControllerProvider.notifier)
            .addWebDavConnection(
              serverUrl: 'https://example.com/dav',
              rootPath: '/',
              username: 'admin',
              password: 'wrongpassword',
            ),
        throwsA(isA<WebDavOperationFailedError>()),
      );

      expect(fakeRepo.connections, isEmpty);
      final state = controller.read(addConnectionControllerProvider);
      expect(state.hasError, isTrue);
    });
  });
}
