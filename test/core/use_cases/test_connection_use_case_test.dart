import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/data/dto/storage_status_dto.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_credential_model.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/services/web_dav_storage_service.dart';
import 'package:sharehop/core/use_cases/test_connection_use_case.dart';
import 'package:sharehop/infrastructures/services/web_dav_storage/error.dart';
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

class FakeUnsupportedCredentialModel implements ConnectionCredentialModel {
  @override
  ConnectionProtocol get protocol => .smb;
}

void main() {
  group('TestConnectionUseCase', () {
    test('calls testConnection on WebDavStorageService successfully', () async {
      final fakeService = FakeWebDavStorageService();
      final useCase = TestConnectionUseCase(fakeService);

      final credential = WebDavCredentialModel(
        url: Uri.parse('https://example.com/dav'),
        username: 'user',
        password: 'password',
      );

      await useCase.call(credential: credential);

      expect(fakeService.passedCredential, credential);
    });

    test('rethrows error when WebDavStorageService fails', () async {
      final fakeService = FakeWebDavStorageService()..shouldThrow = true;
      final useCase = TestConnectionUseCase(fakeService);

      final credential = WebDavCredentialModel(
        url: Uri.parse('https://example.com/dav'),
        username: 'user',
        password: 'wrong-password',
      );

      expect(
        () => useCase.call(credential: credential),
        throwsA(isA<WebDavOperationFailedError>()),
      );
    });

    test('throws UnimplementedError for unsupported credential protocol',
        () async {
      final fakeService = FakeWebDavStorageService();
      final useCase = TestConnectionUseCase(fakeService);

      final credential = FakeUnsupportedCredentialModel();

      expect(
        () => useCase.call(credential: credential),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
