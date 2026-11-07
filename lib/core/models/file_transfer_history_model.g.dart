// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_transfer_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FileTransferHistoryModel _$FileTransferHistoryModelFromJson(
  Map<String, dynamic> json,
) => _FileTransferHistoryModel(
  id: json['id'] as String,
  fileName: json['file_name'] as String,
  fileSize: (json['file_size'] as num).toInt(),
  fileMimeType: json['file_mime_type'] as String,
  sourceName: json['source_name'] as String,
  destinationName: json['destination_name'] as String,
  status: $enumDecode(_$FileTransferStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$FileTransferHistoryModelToJson(
  _FileTransferHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'file_name': instance.fileName,
  'file_size': instance.fileSize,
  'file_mime_type': instance.fileMimeType,
  'source_name': instance.sourceName,
  'destination_name': instance.destinationName,
  'status': _$FileTransferStatusEnumMap[instance.status]!,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$FileTransferStatusEnumMap = {
  FileTransferStatus.pending: 'pending',
  FileTransferStatus.inProgress: 'inProgress',
  FileTransferStatus.completed: 'completed',
  FileTransferStatus.failed: 'failed',
  FileTransferStatus.canceled: 'canceled',
};
