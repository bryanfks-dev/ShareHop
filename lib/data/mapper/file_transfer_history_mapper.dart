import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:uuid/uuid_value.dart';

class FileTransferHistoryMapper {
  const new();

  FileTransferHistoryModel toModel(Map<String, dynamic> row) {
    final statusStr = row['status'] as String;
    final status = _parseStatus(statusStr);

    return FileTransferHistoryModel(
      id: UuidValue.fromString(row['id'] as String),
      fileName: row['file_name'] as String,
      fileSize: (row['file_size'] as num).toInt(),
      fileMimeType: row['file_mime_type'] as String,
      sourceName: row['source_name'] as String,
      destinationName: row['destination_name'] as String,
      status: status,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  Map<String, dynamic> toRow(FileTransferHistoryModel model) => {
    'id': model.id.uuid,
    'file_name': model.fileName,
    'file_size': model.fileSize,
    'file_mime_type': model.fileMimeType,
    'source_name': model.sourceName,
    'destination_name': model.destinationName,
    'status': model.status.persistentValue,
    'created_at': model.createdAt.toIso8601String(),
    'updated_at': model.updatedAt.toIso8601String(),
  };

  FileTransferStatus _parseStatus(String status) {
    for (final s in FileTransferStatus.values) {
      if (s.persistentValue == status || s.name == status) {
        return s;
      }
    }
    return FileTransferStatus.pending;
  }
}
