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
  }) = _ConnectionDto;

  const new _();

  ConnectionProtocol get connectionProtocol => protocol;
}

@freezed
abstract class ConnectionDraftDto with _$ConnectionDraftDto {
  const factory({
    required ConnectionProtocol protocol,
    required String remoteAddress,
    required String username,
    required String password,
    required String displayName,
  }) = _ConnectionDraftDto;

  const new _();
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
  }) = _ConnectionRevisionDto;

  const new _();
}
