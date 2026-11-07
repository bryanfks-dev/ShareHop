import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/mixins/timestamp_mixin.dart';
import 'package:sharehop/core/models/persistence_model.dart';

part 'pinned_connection_model.freezed.dart';
part 'pinned_connection_model.g.dart';

@freezed
abstract class PinnedConnectionModel
    with _$PinnedConnectionModel, TimestampMixin
    implements PersistenceModel {
  const factory({
    required String id,
    @JsonKey(name: 'connection_id') required String connectionId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    ConnectionModel? connection,
  }) = _PinnedConnectionModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$PinnedConnectionModelFromJson(json);

  static String get tableName => 'pinned_connections';
}
