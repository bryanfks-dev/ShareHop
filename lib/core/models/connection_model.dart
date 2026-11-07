import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/models/mixins/id_mixin.dart';
import 'package:sharehop/core/models/mixins/timestamp_mixin.dart';
import 'package:sharehop/core/models/persistence_model.dart';

part 'connection_model.freezed.dart';
part 'connection_model.g.dart';

@freezed
abstract class ConnectionModel
    with _$ConnectionModel, IdMixin, TimestampMixin
    implements PersistenceModel {
  const factory({
    required String id,
    required ConnectionProtocol protocol,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'remote_address') required String remoteAddress,
    required String username,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'password') @Default('') String passwordId,
    @JsonKey(name: 'root_path') @Default('/') String rootPath,
    @JsonKey(includeFromJson: false, includeToJson: false)
    EncryptedValueModel? password,
  }) = _ConnectionModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$ConnectionModelFromJson(json);

  static String get tableName => 'connections';
}
