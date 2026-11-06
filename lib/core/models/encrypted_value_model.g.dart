// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encrypted_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EncryptedValueModel _$EncryptedValueModelFromJson(Map<String, dynamic> json) =>
    _EncryptedValueModel(
      id: json['id'] as String,
      salt: json['salt'] as String,
      nonce: json['nonce'] as String,
      cipherText: json['cipher_text'] as String,
      mac: json['mac'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$EncryptedValueModelToJson(
  _EncryptedValueModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'salt': instance.salt,
  'nonce': instance.nonce,
  'cipher_text': instance.cipherText,
  'mac': instance.mac,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
