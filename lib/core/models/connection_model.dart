import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/base_model.dart';

part 'connection_model.freezed.dart';
part 'connection_model.g.dart';

@freezed
abstract class ConnectionModel with _$ConnectionModel implements BaseModel {
  const factory({
    required String id,
    required ConnectionProtocol protocol,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'remote_address') required String remoteAddress,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ConnectionModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$ConnectionModelFromJson(json);

  static String get tableName => 'connections';
}
