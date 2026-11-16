import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';

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
