import 'package:flutter/services.dart';
import 'package:sharehop/core/data/dto/storage_status_dto.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:webdav_client/webdav_client.dart';

abstract interface class WebDavStorageService {
  Future<List<File>> list({
    required WebDavCredentialModel credential,
    required String path,
  });

  Future<void> createDirectory({
    required WebDavCredentialModel credential,
    required String path,
  });

  Future<void> delete({
    required WebDavCredentialModel credential,
    required String path,
  });

  Future<void> uploadFile({
    required WebDavCredentialModel credential,
    required String path,
    required Uint8List fileBytes,
  });

  Future<Uint8List> downloadFile({
    required WebDavCredentialModel credential,
    required String path,
  });

  Future<void> rename({
    required WebDavCredentialModel credential,
    required String oldPath,
    required String newPath,
  });

  Future<void> copy({
    required WebDavCredentialModel credential,
    required String sourcePath,
    required String destinationPath,
  });

  Future<void> move({
    required WebDavCredentialModel credential,
    required String sourcePath,
    required String destinationPath,
  });

  Future<File> getFileProperties({
    required WebDavCredentialModel credential,
    required String path,
  });

  Future<void> testConnection({
    required WebDavCredentialModel credential,
  });

  Future<StorageStatusDto> getStatus({
    required WebDavCredentialModel credential,
    String path = '/',
  });
}
