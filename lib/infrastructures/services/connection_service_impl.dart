import 'package:sharehop/core/gateways/web_dav_storage_gateway.dart';
import 'package:sharehop/core/models/connection_credential_model.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/services/connection_service.dart';

class ConnectionServiceImpl implements ConnectionService {
  const new(this.webDavStorageGateway);

  final WebDavStorageGateway webDavStorageGateway;

  @override
  Future<void> verify({required ConnectionCredentialModel credential}) async {
    switch (credential) {
      case final WebDavCredentialModel webDavCredential:
        await webDavStorageGateway.testConnection(credential: webDavCredential);
      default:
        throw UnimplementedError(
          'Connection testing for protocol ${credential.protocol.name} is not '
          'supported yet',
        );
    }
  }
}
