import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/data/dto/connection_credential_dto.dart';

part 'web_dav_credential_dto.freezed.dart';

@freezed
class WebDavCredentialDto
    with _$WebDavCredentialDto
    implements ConnectionCredentialDto {
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

typedef WebDavCredentialModel = WebDavCredentialDto;
