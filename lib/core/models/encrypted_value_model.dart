import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/converters/uuid_value_converter.dart';
import 'package:sharehop/core/models/mixins/id_mixin.dart';
import 'package:sharehop/core/models/mixins/timestamp_mixin.dart';
import 'package:sharehop/core/models/persistence_model.dart';
import 'package:uuid/uuid_value.dart';

part 'encrypted_value_model.freezed.dart';
part 'encrypted_value_model.g.dart';

@freezed
abstract class EncryptedValueModel
    with _$EncryptedValueModel, IdMixin, TimestampMixin
    implements PersistenceModel {
  const factory({
    @UuidValueConverter() required UuidValue id,
    required String salt,
    required String nonce,
    required String cipherText,
    required String mac,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EncryptedValueModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$EncryptedValueModelFromJson(json);

  static String get tableName => 'encrypted_values';
}
