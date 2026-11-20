import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';

void main() {
  group('EncryptedValue', () {
    test('instantiates and supports equality and copyWith', () {
      const val = EncryptedValue(
        salt: 's1',
        nonce: 'n1',
        cipherText: 'c1',
        mac: 'm1',
      );

      expect(val.salt, 's1');
      expect(val.nonce, 'n1');
      expect(val.cipherText, 'c1');
      expect(val.mac, 'm1');

      final copied = val.copyWith(mac: 'm2');
      expect(copied.mac, 'm2');
      expect(copied.salt, 's1');

      const same = EncryptedValue(
        salt: 's1',
        nonce: 'n1',
        cipherText: 'c1',
        mac: 'm1',
      );
      expect(val, same);
    });
  });
}
