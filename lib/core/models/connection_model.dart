import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/base_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';

part 'connection_model.freezed.dart';
part 'connection_model.g.dart';

@Freezed(copyWith: false)
abstract class ConnectionModel with _$ConnectionModel implements BaseModel {
  const factory({
    required String id,
    required ConnectionProtocol protocol,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'remote_address') required String remoteAddress,
    required String username,
    required EncryptedValueModel password,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ConnectionModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$ConnectionModelFromJson(json);

  static String get tableName => 'connections';

  ConnectionModel copyWith({
    String? displayName,
    String? remoteAddress,
    String? username,
    EncryptedValueModel? password,
  }) {
    return ConnectionModel(
      id: id,
      protocol: protocol,
      displayName: displayName ?? this.displayName,
      remoteAddress: remoteAddress ?? this.remoteAddress,
      username: username ?? this.username,
      password: password ?? this.password,
      createdAt: createdAt,
      updatedAt: DateTime.now().toUtc(),
    );
  }
}
