import 'package:sharehop/core/repositories/file_transfer_history_repository.dart';

class ClearFileTransferHistoryUseCase {
  const new({required this.repository});

  final FileTransferHistoryRepository repository;

  Future<void> call() => repository.clearAll();
}
