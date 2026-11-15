import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/core/repositories/file_transfer_history_repository.dart';

class GetFileTransferHistoriesUseCase {
  const new({required this.repository});

  final FileTransferHistoryRepository repository;

  Future<List<FileTransferHistoryModel>> call({
    FileTransferStatus? status,
    String? searchQuery,
  }) => repository.getAll(status: status, searchQuery: searchQuery);
}
