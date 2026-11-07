import 'package:sharehop/data/dto/connection_credential_dto.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';

class ConnectionCredentialMapper {
  ConnectionCredentialDto toWebDavCredentialDto(ConnectionDto connection) {
    final uri = Uri.tryParse(connection.remoteAddress);
    return WebDavCredentialDto(
      url: uri != null && uri.hasScheme
          ? uri
          : Uri(host: connection.remoteAddress),
      username: connection.username,
      password: connection.password,
    );
  }

  ConnectionCredentialDto toWebDavCredentialModel(ConnectionDto connection) =>
      toWebDavCredentialDto(connection);
}
