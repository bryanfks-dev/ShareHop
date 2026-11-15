import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';

part 'input.freezed.dart';

@freezed
abstract class CreateConnectionInput with _$CreateConnectionInput {
  const factory({
    required String displayName,
    required String remoteAddress,
    required String username,
    required EncryptedValue password,
    @Default('/') String rootPath,
    @Default(false) bool allowSelfSignedCertificate,
  }) = _CreateConnectionInput;
}
