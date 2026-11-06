import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';

part 'connection_dto.freezed.dart';

@freezed
abstract class ConnectionDto with _$ConnectionDto {
  const factory({
    required ConnectionProtocol connectionProtocol,
    required String remoteAddress,
    required String username,
    required String password,
    String? displayName,
  }) = _ConnectionDto;
}

@freezed
abstract class ConnectionDraftDto with _$ConnectionDraftDto {
  const factory({
    required ConnectionProtocol connectionProtocol,
    required String remoteAddress,
    required String username,
    required String password,
    required String displayName,
  }) = _ConnectionDraftDto;
}
