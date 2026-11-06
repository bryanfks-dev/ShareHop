import 'package:freezed_annotation/freezed_annotation.dart';

part 'encrypted_value_vo.freezed.dart';

@freezed
abstract class EncryptedValueVo with _$EncryptedValueVo {
  const factory({
    required String salt,
    required String nonce,
    @JsonKey(name: 'cipher_text') required String cipherText,
    required String mac,
  }) = _EncryptedValueVo;
}
