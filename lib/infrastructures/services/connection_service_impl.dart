import 'package:sharehop/core/gateways/web_dav_storage_gateway.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/data/dto/connection_credential_dto.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';

class ConnectionServiceImpl implements ConnectionService {
  const new({required this.webDavStorageGateway});

  final WebDavStorageGateway webDavStorageGateway;

  @override
  Future<void> verify({required ConnectionCredentialDto credential}) async {
    switch (credential) {
      case final WebDavCredentialDto webDavCredential:
        await webDavStorageGateway.testConnection(credential: webDavCredential);
      default:
        throw UnimplementedError(
          'Connection testing for protocol ${credential.protocol.name} is not '
          'supported yet',
        );
    }
  }
}
