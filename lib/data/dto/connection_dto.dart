import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/data/converters/not_required_value_converter.dart';
import 'package:sharehop/data/utils/not_required_value.dart';

part 'connection_dto.freezed.dart';

@freezed
abstract class ConnectionDto with _$ConnectionDto {
  const factory({
    required ConnectionProtocol protocol,
    required String remoteAddress,
    required String username,
    required String password,
    String? displayName,
    @Default('/') String rootPath,
    @Default(false) bool allowSelfSignedCertificate,
  }) = _ConnectionDto;

  const new _();

  ConnectionProtocol get connectionProtocol => protocol;
}

@freezed
abstract class ConnectionRevisionDto with _$ConnectionRevisionDto {
  const factory({
    required String id,
    @NotRequiredValueConverter<ConnectionProtocol>()
    NotRequiredValue<ConnectionProtocol>? protocol,
    @NotRequiredValueConverter<String>()
    NotRequiredValue<String>? remoteAddress,
    @NotRequiredValueConverter<String>() NotRequiredValue<String>? username,
    @NotRequiredValueConverter<String>()
    NotRequiredValue<String>? passwordSecretKey,
    @NotRequiredValueConverter<String>() NotRequiredValue<String>? password,
    @NotRequiredValueConverter<String>() NotRequiredValue<String>? displayName,
    @NotRequiredValueConverter<String>() NotRequiredValue<String>? rootPath,
    @NotRequiredValueConverter<bool>()
    NotRequiredValue<bool>? allowSelfSignedCertificate,
  }) = _ConnectionRevisionDto;

  const new _();

  Map<String, dynamic> toMap({DateTime? updatedAt}) {
    final effectiveUpdatedAt = updatedAt ?? DateTime.now().toUtc();
    return {
      'id': id,
      if (protocol != null) 'protocol': protocol,
      if (remoteAddress != null) 'remote_address': remoteAddress,
      if (username != null) 'username': username,
      if (passwordSecretKey != null) 'password_secret_key': passwordSecretKey,
      if (password != null) 'password': password,
      if (displayName != null) 'display_name': displayName,
      if (rootPath != null) 'root_path': rootPath,
      if (allowSelfSignedCertificate != null)
        'allow_self_signed_certificate': allowSelfSignedCertificate,
      'updated_at': NotRequiredValue(effectiveUpdatedAt.toIso8601String()),
    };
  }
}
