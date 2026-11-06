import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_credential_model.dart';

part 'web_dav_credential_model.freezed.dart';

@freezed
class WebDavCredentialModel
    with _$WebDavCredentialModel
    implements ConnectionCredentialModel {
  new({required this.url, required this.username, required this.password});

  final Uri url;
  final String username;
  final String password;

  @override
  ConnectionProtocol get protocol => .webdav;

  @override
  String toString() =>
      'WebDavCredential(url: $url, username: $username, password: '
      '${'*' * password.length})';
}
