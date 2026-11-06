import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/models/base_model.dart';

part 'encrypted_value_model.freezed.dart';
part 'encrypted_value_model.g.dart';

@freezed
abstract class EncryptedValueModel
    with _$EncryptedValueModel
    implements BaseModel {
  const factory({
    required String id,
    required String salt,
    required String nonce,
    @JsonKey(name: 'cipher_text') required String cipherText,
    required String mac,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _EncryptedValueModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$EncryptedValueModelFromJson(json);

  static String get tableName => 'encrypted_values';
}
