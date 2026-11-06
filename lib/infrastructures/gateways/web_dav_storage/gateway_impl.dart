import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:sharehop/core/gateways/web_dav_storage_gateway.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/data/dto/storage_status_dto.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_manager.dart';
import 'package:webdav_client/webdav_client.dart';

class WebDavStorageGatewayImpl implements WebDavStorageGateway {
  const new(this.clientManager);

  final WebDavClientManager clientManager;

  @override
  Future<List<File>> list({
    required WebDavCredentialModel credential,
    required String path,
  }) async {
    try {
      return await clientManager.useClientWithDisposal(
        (client) => client.readDir(path),
        credential: credential,
      );
    } on Exception catch (e) {
      log('Failed to list files in path: $path', error: e);
      throw WebDavOperationFailedError('Failed to list files in path: $path');
    }
  }

  @override
  Future<void> createDirectory({
    required WebDavCredentialModel credential,
    required String path,
  }) async {
    try {
      return await clientManager.useClientWithDisposal(
        (client) => client.mkdir(path),
        credential: credential,
      );
    } on Exception catch (e) {
      log('Failed to create directory at path: $path', error: e);
      throw WebDavOperationFailedError(
        'Failed to create directory at path: $path',
      );
    }
  }

  @override
  Future<void> delete({
    required WebDavCredentialModel credential,
    required String path,
  }) async {
    try {
      return await clientManager.useClientWithDisposal(
        (client) => client.remove(path),
        credential: credential,
      );
    } on Exception catch (e) {
      log('Failed to delete file or directory at path: $path', error: e);
      throw WebDavOperationFailedError(
        'Failed to delete file or directory at path: $path',
      );
    }
  }

  @override
  Future<void> uploadFile({
    required WebDavCredentialModel credential,
    required String path,
    required Uint8List fileBytes,
  }) async {
    try {
      return await clientManager.useClientWithDisposal(
        (client) => client.write(path, fileBytes),
        credential: credential,
      );
    } on Exception catch (e) {
      log('Failed to upload file to path: $path', error: e);
      throw WebDavOperationFailedError('Failed to upload file to path: $path');
    }
  }

  @override
  Future<Uint8List> downloadFile({
    required WebDavCredentialModel credential,
    required String path,
  }) async {
    try {
      final fileContent = await clientManager.useClientWithDisposal(
        (client) => client.read(path),
        credential: credential,
      );
      return Uint8List.fromList(fileContent);
    } on Exception catch (e) {
      log('Failed to download file from path: $path', error: e);
      throw WebDavOperationFailedError(
        'Failed to download file from path: $path',
      );
    }
  }

  @override
  Future<void> rename({
    required WebDavCredentialModel credential,
    required String oldPath,
    required String newPath,
  }) async {
    try {
      return await clientManager.useClientWithDisposal(
        (client) => client.rename(oldPath, newPath, true),
        credential: credential,
      );
    } on Exception catch (e) {
      log(
        'Failed to rename file or directory from $oldPath to $newPath',
        error: e,
      );
      throw WebDavOperationFailedError(
        'Failed to rename file or directory from $oldPath to $newPath',
      );
    }
  }

  @override
  Future<void> copy({
    required WebDavCredentialModel credential,
    required String sourcePath,
    required String destinationPath,
  }) async {
    try {
      return await clientManager.useClientWithDisposal(
        (client) => client.copy(sourcePath, destinationPath, true),
        credential: credential,
      );
    } on Exception catch (e) {
      log(
        'Failed to move file or directory from $sourcePath to $destinationPath',
        error: e,
      );
      throw WebDavOperationFailedError(
        'Failed to move file or directory from $sourcePath to $destinationPath',
      );
    }
  }

  @override
  Future<void> move({
    required WebDavCredentialModel credential,
    required String sourcePath,
    required String destinationPath,
  }) async {
    try {
      return await clientManager.useClientWithDisposal(
        (client) => client.rename(sourcePath, destinationPath, true),
        credential: credential,
      );
    } on Exception catch (e) {
      log(
        'Failed to move file or directory from $sourcePath to $destinationPath',
        error: e,
      );
      throw WebDavOperationFailedError(
        'Failed to move file or directory from $sourcePath to $destinationPath',
      );
    }
  }

  @override
  Future<File> getFileProperties({
    required WebDavCredentialModel credential,
    required String path,
  }) async {
    try {
      return await clientManager.useClientWithDisposal(
        (client) => client.readProps(path),
        credential: credential,
      );
    } on Exception catch (e) {
      log('Failed to get file properties for path: $path', error: e);
      throw WebDavOperationFailedError(
        'Failed to get file properties for path: $path',
      );
    }
  }

  @override
  Future<void> testConnection({
    required WebDavCredentialModel credential,
  }) async {
    try {
      await clientManager.useClientWithDisposal(
        (client) => client.ping(),
        credential: credential,
      );
    } on Exception catch (e) {
      log('Failed to test WebDAV connection', error: e);
      throw WebDavOperationFailedError('Failed to connect to WebDAV server');
    }
  }

  @override
  Future<StorageStatusDto> getStatus({
    required WebDavCredentialModel credential,
    String path = '/',
  }) async {
    try {
      return await clientManager.useClientWithDisposal((client) async {
        const quotaXmlStr = '''
<d:propfind xmlns:d="DAV:">
  <d:prop>
    <d:quota-available-bytes/>
    <d:quota-used-bytes/>
  </d:prop>
</d:propfind>''';

        final normalizedPath = path.isEmpty || path == '/'
            ? '/'
            : (path.startsWith('/') ? path : '/$path');

        final response = await client.c.wdPropfind(
          client,
          normalizedPath,
          false,
          quotaXmlStr,
        );

        final xmlData = response.data.toString();

        final availableMatch = RegExp(
          r'<(?:\w+:)?quota-available-bytes[^>]*>\s*(-?[0-9]+)\s*<\/(?:\w+:)?quota-available-bytes>',
          caseSensitive: false,
        ).firstMatch(xmlData);

        final usedMatch = RegExp(
          r'<(?:\w+:)?quota-used-bytes[^>]*>\s*(-?[0-9]+)\s*<\/(?:\w+:)?quota-used-bytes>',
          caseSensitive: false,
        ).firstMatch(xmlData);

        if (availableMatch == null && usedMatch == null) {
          throw WebDavOperationFailedError(
            'Failed to parse storage status: quota properties not found '
            'in response',
          );
        }

        final rawAvailable = int.tryParse(availableMatch?.group(1) ?? '') ?? 0;
        final rawUsed = int.tryParse(usedMatch?.group(1) ?? '') ?? 0;

        final availableBytes = rawAvailable < 0 ? 0 : rawAvailable;
        final usedBytes = rawUsed < 0 ? 0 : rawUsed;
        final totalBytes = availableBytes + usedBytes;

        return StorageStatusDto(
          totalBytes: totalBytes,
          freeBytes: availableBytes,
          updatedAt: DateTime.now(),
        );
      }, credential: credential);
    } on WebDavOperationFailedError {
      rethrow;
    } on Exception catch (e) {
      log('Failed to get storage status for path: $path', error: e);
      throw WebDavOperationFailedError('Failed to get storage status');
    }
  }
}
