import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/converters/bool_int_converter.dart';
import 'package:sharehop/core/converters/uuid_value_converter.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/models/mixins/id_mixin.dart';
import 'package:sharehop/core/models/mixins/timestamp_mixin.dart';
import 'package:sharehop/core/models/persistence_model.dart';
import 'package:uuid/uuid.dart';

part 'connection_model.freezed.dart';
part 'connection_model.g.dart';

@freezed
abstract class ConnectionModel
    with _$ConnectionModel, IdMixin, TimestampMixin
    implements PersistenceModel {
  const factory({
    @UuidValueConverter() required UuidValue id,
    required ConnectionProtocol protocol,
    required String displayName,
    required String remoteAddress,
    required String username,
    @UuidValueConverter() required UuidValue passwordId,
    required String rootPath,
    required DateTime createdAt,
    required DateTime updatedAt,
    @BoolIntConverter()
    @JsonKey(name: 'allow_self_signed_certificate')
    @Default(false)
    bool allowSelfSignedCertificate,
    @JsonKey(includeFromJson: false, includeToJson: false)
    EncryptedValueModel? password,
  }) = _ConnectionModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$ConnectionModelFromJson(json);

  static String get tableName => 'connections';
}
