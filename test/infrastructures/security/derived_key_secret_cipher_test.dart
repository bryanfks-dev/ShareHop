import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/infrastructures/security/derived_key_secret_cipher.dart';

void main() {
  group('DerivedKeySecretCipher', () {
    test('encrypts and decrypts text back to original value', () async {
      final cipher = DerivedKeySecretCipher('my-super-secret-key-12345');

      const originalText = 'SuperSecretPassword!';
      final encrypted = await cipher.encrypt(originalText);

      expect(encrypted.cipherText, isNotEmpty);
      expect(encrypted.salt, isNotEmpty);
      expect(encrypted.nonce, isNotEmpty);
      expect(encrypted.mac, isNotEmpty);
      expect(encrypted.cipherText, isNot(equals(originalText)));

      final decrypted = await cipher.decrypt(encrypted);
      expect(decrypted, equals(originalText));
    });

    test('decrypting with wrong secret fails', () async {
      final cipher = DerivedKeySecretCipher('secret-a');
      final otherCipher = DerivedKeySecretCipher('secret-b');

      final encrypted = await cipher.encrypt('Hello World');

      expect(() => otherCipher.decrypt(encrypted), throwsA(anything));
    });
  });
}
