import 'package:sharehop/data/utils/encrypted_value.dart';

abstract interface class SecretCipher {
  Future<EncryptedValue> encrypt(String text);
  Future<String> decrypt(EncryptedValue value);
}

typedef SecretCipherFactory = SecretCipher Function(String secret);
