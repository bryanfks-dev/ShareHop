// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinned_connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PinnedConnectionModel _$PinnedConnectionModelFromJson(
  Map<String, dynamic> json,
) => _PinnedConnectionModel(
  id: json['id'] as String,
  connectionId: json['connection_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PinnedConnectionModelToJson(
  _PinnedConnectionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'connection_id': instance.connectionId,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
