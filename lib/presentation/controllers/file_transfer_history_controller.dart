import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/di/file_transfer_history_di.dart';
import 'package:uuid/uuid_value.dart';

part 'file_transfer_history_controller.g.dart';

class FileTransferHistoryState {
  const new({
    this.histories = const [],
    this.selectedStatus,
    this.searchQuery = '',
    this.isLoading = false,
  });

  final List<FileTransferHistoryModel> histories;
  final FileTransferStatus? selectedStatus;
  final String searchQuery;
  final bool isLoading;

  FileTransferHistoryState copyWith({
    List<FileTransferHistoryModel>? histories,
    FileTransferStatus? Function()? selectedStatus,
    String? searchQuery,
    bool? isLoading,
  }) {
    return FileTransferHistoryState(
      histories: histories ?? this.histories,
      selectedStatus: selectedStatus != null
          ? selectedStatus()
          : this.selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@Riverpod(keepAlive: true)
class FileTransferHistoryController extends _$FileTransferHistoryController {
  @override
  FileTransferHistoryState build() {
    unawaited(_loadHistories());
    return const FileTransferHistoryState(isLoading: true);
  }

  Future<void> _loadHistories({
    FileTransferStatus? status,
    String? searchQuery,
    bool clearStatus = false,
  }) async {
    final currentStatus = clearStatus
        ? null
        : (status ?? stateOrNull?.selectedStatus);
    final currentQuery = searchQuery ?? stateOrNull?.searchQuery ?? '';

    try {
      final getHistories = ref.read(getFileTransferHistoriesUseCaseProvider);
      final results = await getHistories(
        status: currentStatus,
        searchQuery: currentQuery,
      );

      state = FileTransferHistoryState(
        histories: results,
        selectedStatus: currentStatus,
        searchQuery: currentQuery,
      );
    } on Object catch (e, st) {
      log(
        'Failed to load transfer histories',
        name: 'FileTransferHistoryController',
        error: e,
        stackTrace: st,
      );
      state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
        isLoading: false,
      );
    }
  }

  Future<void> filterByStatus(FileTransferStatus? status) async {
    state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
      selectedStatus: () => status,
      isLoading: true,
    );
    await _loadHistories(status: status, clearStatus: status == null);
  }

  Future<void> setSearchQuery(String query) async {
    state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
      searchQuery: query,
      isLoading: true,
    );
    await _loadHistories(searchQuery: query);
  }

  Future<void> clearHistory() async {
    try {
      final clearUseCase = ref.read(clearFileTransferHistoryUseCaseProvider);
      await clearUseCase();
      state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
        histories: [],
      );
    } on Object catch (e, st) {
      log(
        'Failed to clear transfer history',
        name: 'FileTransferHistoryController',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> deleteHistory(UuidValue id) async {
    try {
      final deleteUseCase = ref.read(deleteFileTransferHistoryUseCaseProvider);
      await deleteUseCase(id: id);
      final current = stateOrNull?.histories ?? [];
      final updated = current.where((item) => item.id != id).toList();
      state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
        histories: updated,
      );
    } on Object catch (e, st) {
      log(
        'Failed to delete transfer history',
        name: 'FileTransferHistoryController',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> refresh() => _loadHistories();
}
