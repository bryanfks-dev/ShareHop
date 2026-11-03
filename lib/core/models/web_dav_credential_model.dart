import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_dav_credential_model.freezed.dart';

@freezed
class WebDavCredentialModel with _$WebDavCredentialModel {
  new({required this.url, required this.username, required this.password});

  final Uri url;
  final String username;
  final String password;

  @override
  String toString() =>
      'WebDavCredential(url: $url, username: $username, password: '
      '${'*' * password.length})';
}
