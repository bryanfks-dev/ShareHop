import 'package:sharehop/core/models/connection_credential_model.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/services/web_dav_storage_service.dart';

class TestConnectionUseCase {
  const new(this._webDavStorageService);

  final WebDavStorageService _webDavStorageService;

  bool isSupported(ConnectionCredentialModel credential) =>
      switch (credential) {
        WebDavCredentialModel _ => true,
        _ => false,
      };

  Future<void> call({required ConnectionCredentialModel credential}) async {
    switch (credential) {
      case final WebDavCredentialModel webDavCredential:
        await _webDavStorageService.testConnection(
          credential: webDavCredential,
        );
      default:
        throw UnimplementedError(
          'Connection testing for protocol ${credential.protocol.name} is not '
          'supported yet',
        );
    }
  }
}
