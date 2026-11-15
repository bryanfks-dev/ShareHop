import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';

void main() {
  group('EncryptedValueMapper', () {
    test(
      'toEncryptedValueModel maps EncryptedValue to model with explicit date',
      () {
        const mapper = EncryptedValueMapper();
        final testDate = DateTime.utc(2026, 11, 7, 12);
        const vo = EncryptedValue(
          salt: 'salt123',
          cipherText: 'cipher123',
          nonce: 'nonce123',
          mac: 'mac123',
        );

        final model = mapper.toEncryptedValueModel(vo, date: testDate);

        expect(model.id.uuid, isNotEmpty);
        expect(model.salt, 'salt123');
        expect(model.cipherText, 'cipher123');
        expect(model.nonce, 'nonce123');
        expect(model.mac, 'mac123');
        expect(model.createdAt, testDate);
        expect(model.updatedAt, testDate);
      },
    );

    test(
      'toEncryptedValueModel defaults date to current UTC time when omitted',
      () {
        const mapper = EncryptedValueMapper();
        const vo = EncryptedValue(
          salt: 'salt123',
          cipherText: 'cipher123',
          nonce: 'nonce123',
          mac: 'mac123',
        );

        final before = DateTime.now().toUtc().subtract(
          const Duration(seconds: 1),
        );
        final model = mapper.toEncryptedValueModel(vo);
        final after = DateTime.now().toUtc().add(const Duration(seconds: 1));

        expect(model.createdAt.isAfter(before), isTrue);
        expect(model.createdAt.isBefore(after), isTrue);
      },
    );
  });
}
