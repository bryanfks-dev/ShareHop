import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/services/web_dav_storage_service.dart';

class TestWebDavConnectionUseCase {
  const new(this._webDavStorageService);

  final WebDavStorageService _webDavStorageService;

  Future<void> call({
    required WebDavCredentialModel credential,
  }) async =>
      await _webDavStorageService.testConnection(credential: credential);
}
