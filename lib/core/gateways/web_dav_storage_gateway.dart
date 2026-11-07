import 'package:flutter/services.dart';
import 'package:sharehop/data/dto/storage_status_dto.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:webdav_client/webdav_client.dart';

abstract interface class WebDavStorageGateway {
  Future<List<File>> list({
    required WebDavCredentialDto credential,
    required String path,
  });
  Future<void> createDirectory({
    required WebDavCredentialDto credential,
    required String path,
  });
  Future<void> delete({
    required WebDavCredentialDto credential,
    required String path,
  });
  Future<void> uploadFile({
    required WebDavCredentialDto credential,
    required String path,
    required Uint8List fileBytes,
  });
  Future<Uint8List> downloadFile({
    required WebDavCredentialDto credential,
    required String path,
  });
  Future<void> rename({
    required WebDavCredentialDto credential,
    required String oldPath,
    required String newPath,
  });
  Future<void> copy({
    required WebDavCredentialDto credential,
    required String sourcePath,
    required String destinationPath,
  });
  Future<void> move({
    required WebDavCredentialDto credential,
    required String sourcePath,
    required String destinationPath,
  });

  Future<File> getFileProperties({
    required WebDavCredentialDto credential,
    required String path,
  });
  Future<void> testConnection({required WebDavCredentialDto credential});
  Future<StorageStatusDto> getStatus({
    required WebDavCredentialDto credential,
    String path = '/',
  });
}
