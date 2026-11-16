import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/repositories/file_transfer_history_repository.dart';
import 'package:sharehop/core/use_cases/clear_file_transfer_history_use_case.dart';
import 'package:sharehop/core/use_cases/delete_file_transfer_history_use_case.dart';
import 'package:sharehop/core/use_cases/get_file_transfer_histories_use_case.dart';
import 'package:sharehop/core/use_cases/update_file_transfer_history_use_case.dart';
import 'package:sharehop/data/mapper/file_transfer_history_mapper.dart';
import 'package:sharehop/infrastructures/repositories/file_transfer_history/repository_impl.dart';

part 'file_transfer_history_di.g.dart';

@Riverpod(keepAlive: true)
FileTransferHistoryMapper fileTransferHistoryMapper(Ref ref) =>
    const FileTransferHistoryMapper();

@Riverpod(keepAlive: true)
FileTransferHistoryRepository fileTransferHistoryRepository(Ref ref) =>
    FileTransferHistoryRepositoryImpl(
      mapper: ref.watch(fileTransferHistoryMapperProvider),
    );

@Riverpod(keepAlive: true)
GetFileTransferHistoriesUseCase getFileTransferHistoriesUseCase(Ref ref) =>
    GetFileTransferHistoriesUseCase(
      repository: ref.watch(fileTransferHistoryRepositoryProvider),
    );

@Riverpod(keepAlive: true)
ClearFileTransferHistoryUseCase clearFileTransferHistoryUseCase(Ref ref) =>
    ClearFileTransferHistoryUseCase(
      repository: ref.watch(fileTransferHistoryRepositoryProvider),
    );

@Riverpod(keepAlive: true)
DeleteFileTransferHistoryUseCase deleteFileTransferHistoryUseCase(Ref ref) =>
    DeleteFileTransferHistoryUseCase(
      repository: ref.watch(fileTransferHistoryRepositoryProvider),
    );

@Riverpod(keepAlive: true)
UpdateFileTransferHistoryUseCase updateFileTransferHistoryUseCase(Ref ref) =>
    UpdateFileTransferHistoryUseCase(
      repository: ref.watch(fileTransferHistoryRepositoryProvider),
    );
