import 'package:sharehop/core/repositories/file_transfer_history_repository.dart';
import 'package:uuid/uuid_value.dart';

class DeleteFileTransferHistoryUseCase {
  const new({required this.repository});

  final FileTransferHistoryRepository repository;

  Future<void> call({required UuidValue id}) => repository.delete(id);
}
