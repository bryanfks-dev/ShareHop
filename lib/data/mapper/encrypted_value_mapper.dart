import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';
import 'package:uuid/uuid.dart';

class EncryptedValueMapper {
  const new();

  EncryptedValueModel toEncryptedValueModel(
    EncryptedValue value, {
    DateTime? date,
  }) {
    final effectiveDate = date ?? DateTime.now().toUtc();
    return EncryptedValueModel(
      id: const Uuid().v7obj(),
      salt: value.salt,
      cipherText: value.cipherText,
      nonce: value.nonce,
      mac: value.mac,
      createdAt: effectiveDate,
      updatedAt: effectiveDate,
    );
  }

  EncryptedValueModel? toEncryptedValueModelFromRow(
    Map<String, dynamic> row, {
    String prefix = 'ev_',
  }) {
    final id = row['${prefix}id'];
    if (id == null) {
      return null;
    }
    return EncryptedValueModel.fromJson({
      'id': id,
      'salt': row['${prefix}salt'],
      'nonce': row['${prefix}nonce'],
      'cipher_text': row['${prefix}cipher_text'],
      'mac': row['${prefix}mac'],
      'created_at': row['${prefix}created_at'],
      'updated_at': row['${prefix}updated_at'],
    });
  }
}
