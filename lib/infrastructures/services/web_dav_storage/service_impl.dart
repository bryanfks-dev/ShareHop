import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/services/web_dav_storage_service.dart';
import 'package:sharehop/infrastructures/services/web_dav_storage/error.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_manager.dart';
import 'package:webdav_client/webdav_client.dart';

class WebDavStorageServiceImpl implements WebDavStorageService {
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
}
