import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:uuid/uuid_value.dart';

abstract interface class FileTransferHistoryRepository {
  Future<List<FileTransferHistoryModel>> getAll({
    FileTransferStatus? status,
    String? searchQuery,
  });
  Future<FileTransferHistoryModel?> getById(UuidValue id);
  Future<void> insert(FileTransferHistoryModel history);
  Future<void> update(FileTransferHistoryModel history);
  Future<void> delete(UuidValue id);
  Future<void> clearAll();
}
