// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinned_connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PinnedConnectionModel _$PinnedConnectionModelFromJson(
  Map<String, dynamic> json,
) => _PinnedConnectionModel(
  connectionId: const UuidValueConverter().fromJson(
    json['connection_id'] as String,
  ),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PinnedConnectionModelToJson(
  _PinnedConnectionModel instance,
) => <String, dynamic>{
  'connection_id': const UuidValueConverter().toJson(instance.connectionId),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
