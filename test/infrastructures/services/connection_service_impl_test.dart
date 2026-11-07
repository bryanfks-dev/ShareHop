import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/gateways/web_dav_storage_gateway.dart';
import 'package:sharehop/data/dto/connection_credential_dto.dart';
import 'package:sharehop/data/dto/storage_status_dto.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';
import 'package:sharehop/infrastructures/services/connection_service_impl.dart';
import 'package:webdav_client/webdav_client.dart';

class FakeWebDavStorageGateway implements WebDavStorageGateway {
  bool shouldThrow = false;
  WebDavCredentialDto? passedCredential;

  @override
  Future<void> testConnection({
    required WebDavCredentialDto credential,
  }) async {
    passedCredential = credential;
    if (shouldThrow) {
      throw WebDavOperationFailedError(message: 'Connection failed');
    }
  }

  @override
  Future<void> copy({
    required WebDavCredentialDto credential,
    required String sourcePath,
    required String destinationPath,
  }) async {}

  @override
  Future<void> createDirectory({
    required WebDavCredentialDto credential,
    required String path,
  }) async {}

  @override
  Future<void> delete({
    required WebDavCredentialDto credential,
    required String path,
  }) async {}

  @override
  Future<Uint8List> downloadFile({
    required WebDavCredentialDto credential,
    required String path,
  }) async => Uint8List(0);

  @override
  Future<File> getFileProperties({
    required WebDavCredentialDto credential,
    required String path,
  }) async => throw UnimplementedError();

  @override
  Future<StorageStatusDto> getStatus({
    required WebDavCredentialDto credential,
    String path = '/',
  }) async => const StorageStatusDto(totalBytes: 100, freeBytes: 50);

  @override
  Future<List<File>> list({
    required WebDavCredentialDto credential,
    required String path,
  }) async => [];

  @override
  Future<void> move({
    required WebDavCredentialDto credential,
    required String sourcePath,
    required String destinationPath,
  }) async {}

  @override
  Future<void> rename({
    required WebDavCredentialDto credential,
    required String oldPath,
    required String newPath,
  }) async {}

  @override
  Future<void> uploadFile({
    required WebDavCredentialDto credential,
    required String path,
    required Uint8List fileBytes,
  }) async {}
}

class FakeOtherCredential implements ConnectionCredentialDto {
  @override
  ConnectionProtocol get protocol => ConnectionProtocol.smb;
}

void main() {
  group('ConnectionServiceImpl', () {
    test(
      'verify calls webDavStorageGateway.testConnection for WebDAV',
      () async {
        final gateway = FakeWebDavStorageGateway();
        final service = ConnectionServiceImpl(webDavStorageGateway: gateway);

        final credential = WebDavCredentialDto(
          url: Uri.parse('https://example.com'),
          username: 'user',
          password: 'pwd',
        );

        await service.verify(credential: credential);

        expect(gateway.passedCredential, credential);
      },
    );

    test(
      'verify throws UnimplementedError for non-WebDAV credentials',
      () async {
        final gateway = FakeWebDavStorageGateway();
        final service = ConnectionServiceImpl(webDavStorageGateway: gateway);

        final otherCredential = FakeOtherCredential();

        expect(
          () => service.verify(credential: otherCredential),
          throwsA(isA<UnimplementedError>()),
        );
      },
    );

    test('verify propagates error when testConnection fails', () async {
      final gateway = FakeWebDavStorageGateway()..shouldThrow = true;
      final service = ConnectionServiceImpl(webDavStorageGateway: gateway);

      final credential = WebDavCredentialDto(
        url: Uri.parse('https://example.com'),
        username: 'user',
        password: 'pwd',
      );

      expect(
        () => service.verify(credential: credential),
        throwsA(isA<WebDavOperationFailedError>()),
      );
    });
  });
}
