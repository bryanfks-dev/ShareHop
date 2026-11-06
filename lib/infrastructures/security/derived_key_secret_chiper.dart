import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/data/value_object/encrypted_value_vo.dart';

class DerivedKeySecretChiper implements SecretCipher {
  new(this.secret);

  final String secret;

  final _aes = AesGcm.with256bits();
  final _pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 100000,
    bits: 256,
  );

  @override
  Future<EncryptedValueVo> encrypt(String text) async {
    final salt = _aes.newNonce();
    final key = await _deriveKey(salt);
    final box = await _aes.encrypt(text.codeUnits, secretKey: key, nonce: salt);

    return EncryptedValueVo(
      salt: base64Encode(salt),
      nonce: base64Encode(box.nonce),
      cipherText: base64Encode(box.cipherText),
      mac: base64Encode(box.mac.bytes),
    );
  }

  @override
  Future<String> decrypt(EncryptedValueVo encryptedValue) async {
    final key = await _deriveKey(base64Decode(encryptedValue.salt));
    final clear = await _aes.decrypt(
      SecretBox(
        base64Decode(encryptedValue.cipherText),
        nonce: base64Decode(encryptedValue.nonce),
        mac: Mac(base64Decode(encryptedValue.mac)),
      ),
      secretKey: key,
    );
    return utf8.decode(clear);
  }

  Future<SecretKey> _deriveKey(List<int> salt) async =>
      await _pbkdf2.deriveKeyFromPassword(password: secret, nonce: salt);
}
