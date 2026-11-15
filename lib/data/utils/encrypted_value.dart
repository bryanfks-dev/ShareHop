import 'package:freezed_annotation/freezed_annotation.dart';

part 'encrypted_value.freezed.dart';

@freezed
abstract class EncryptedValue with _$EncryptedValue {
  const factory({
    required String salt,
    required String nonce,
    required String cipherText,
    required String mac,
  }) = _EncryptedValue;
}
