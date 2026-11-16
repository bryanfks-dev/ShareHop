import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/core/repositories/file_transfer_history_repository.dart';

class UpdateFileTransferHistoryUseCase {
  const new({required this.repository});

  final FileTransferHistoryRepository repository;

  Future<void> call({required FileTransferHistoryModel history}) =>
      repository.update(history);
}
