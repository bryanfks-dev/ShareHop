import 'package:sharehop/data/value_object/encrypted_value_vo.dart';

abstract interface class SecretCipher {
  Future<EncryptedValueVo> encrypt(String text);
  Future<String> decrypt(EncryptedValueVo value);
}
