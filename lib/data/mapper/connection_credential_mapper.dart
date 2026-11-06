import 'package:sharehop/core/models/connection_credential_model.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';

class ConnectionCredentialMapper {
  ConnectionCredentialModel toWebDavCredentialModel(ConnectionDto connection) {
    return WebDavCredentialModel(
      url: Uri(host: connection.remoteAddress),
      username: connection.username,
      password: connection.password,
    );
  }
}
