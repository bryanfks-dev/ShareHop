import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';

void main() {
  group('EncryptedValueMapper', () {
    test(
      'toEncryptedValueModel maps EncryptedValueVo to EncryptedValueModel',
      () {
        final mapper = EncryptedValueMapper();
        const vo = EncryptedValue(
          salt: 'salt123',
          cipherText: 'cipher123',
          nonce: 'nonce123',
          mac: 'mac123',
        );

        final model = mapper.toEncryptedValueModel(vo);

        expect(model.id, isNotEmpty);
        expect(model.salt, 'salt123');
        expect(model.cipherText, 'cipher123');
        expect(model.nonce, 'nonce123');
        expect(model.mac, 'mac123');
        expect(model.createdAt, isNotNull);
        expect(model.updatedAt, isNotNull);
      },
    );
  });
}
