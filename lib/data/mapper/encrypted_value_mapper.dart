import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/data/value_object/encrypted_value_vo.dart';
import 'package:uuid/uuid.dart';

class EncryptedValueMapper {
  EncryptedValueModel toEncryptedValueModel(EncryptedValueVo value) {
    final now = DateTime.now().toUtc();

    return EncryptedValueModel(
      id: const Uuid().v7(),
      salt: value.salt,
      cipherText: value.cipherText,
      nonce: value.nonce,
      mac: value.mac,
      createdAt: now,
      updatedAt: now,
    );
  }
}
