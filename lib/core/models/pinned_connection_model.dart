import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/converters/uuid_value_converter.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/mixins/timestamp_mixin.dart';
import 'package:sharehop/core/models/persistence_model.dart';
import 'package:uuid/uuid_value.dart';

part 'pinned_connection_model.freezed.dart';
part 'pinned_connection_model.g.dart';

@freezed
abstract class PinnedConnectionModel
    with _$PinnedConnectionModel, TimestampMixin
    implements PersistenceModel {
  const factory({
    @UuidValueConverter() required UuidValue connectionId,
    required DateTime createdAt,
    required DateTime updatedAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    ConnectionModel? connection,
  }) = _PinnedConnectionModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$PinnedConnectionModelFromJson(json);

  static String get tableName => 'pinned_connections';
}
