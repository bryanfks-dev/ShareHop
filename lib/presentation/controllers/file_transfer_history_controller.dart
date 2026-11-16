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
    this.selectedConnection,
    this.isLoading = false,
  });

  final List<FileTransferHistoryModel> histories;
  final FileTransferStatus? selectedStatus;
  final String searchQuery;
  final String? selectedConnection;
  final bool isLoading;

  List<FileTransferHistoryModel> get filteredHistories {
    if (selectedConnection == null || selectedConnection!.isEmpty) {
      return histories;
    }
    final connectionLower = selectedConnection!.toLowerCase();
    return histories.where((item) {
      final s = item.sourceName.toLowerCase();
      final d = item.destinationName.toLowerCase();
      return s == connectionLower ||
          d == connectionLower ||
          s.contains(connectionLower) ||
          d.contains(connectionLower);
    }).toList();
  }

  FileTransferHistoryState copyWith({
    List<FileTransferHistoryModel>? histories,
    FileTransferStatus? Function()? selectedStatus,
    String? searchQuery,
    String? Function()? selectedConnection,
    bool? isLoading,
  }) {
    return FileTransferHistoryState(
      histories: histories ?? this.histories,
      selectedStatus: selectedStatus != null
          ? selectedStatus()
          : this.selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedConnection: selectedConnection != null
          ? selectedConnection()
          : this.selectedConnection,
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
        selectedConnection: stateOrNull?.selectedConnection,
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

  Future<void> filterByConnection(String? connection) async {
    state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
      selectedConnection: () => connection,
    );
  }

  Future<void> cancelTransfer(UuidValue id) async {
    try {
      final updateUseCase = ref.read(updateFileTransferHistoryUseCaseProvider);
      final current = stateOrNull?.histories ?? [];
      final item = current.where((e) => e.id == id).firstOrNull;
      if (item != null) {
        final updated = item.copyWith(status: .canceled, updatedAt: .now());
        await updateUseCase(history: updated);
        final updatedList = current
            .map((e) => e.id == id ? updated : e)
            .toList();
        state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
          histories: updatedList,
        );
      }
    } on Object catch (e, st) {
      log(
        'Failed to cancel transfer',
        name: 'FileTransferHistoryController',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> cancelAllActive({String? connection}) async {
    try {
      final updateUseCase = ref.read(updateFileTransferHistoryUseCaseProvider);
      final current = stateOrNull?.histories ?? [];
      final now = DateTime.now();
      final connLower = connection?.toLowerCase();
      final updatedList = <FileTransferHistoryModel>[];
      for (final item in current) {
        final matchesConn =
            connLower == null ||
            item.sourceName.toLowerCase() == connLower ||
            item.destinationName.toLowerCase() == connLower ||
            item.sourceName.toLowerCase().contains(connLower) ||
            item.destinationName.toLowerCase().contains(connLower);
        if (item.status == FileTransferStatus.inProgress && matchesConn) {
          final updated = item.copyWith(
            status: FileTransferStatus.canceled,
            updatedAt: now,
          );
          await updateUseCase(history: updated);
          updatedList.add(updated);
        } else {
          updatedList.add(item);
        }
      }
      state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
        histories: updatedList,
      );
    } on Object catch (e, st) {
      log(
        'Failed to cancel all active transfers',
        name: 'FileTransferHistoryController',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> cancelAllQueued({String? connection}) async {
    try {
      final updateUseCase = ref.read(updateFileTransferHistoryUseCaseProvider);
      final current = stateOrNull?.histories ?? [];
      final now = DateTime.now();
      final connLower = connection?.toLowerCase();
      final updatedList = <FileTransferHistoryModel>[];
      for (final item in current) {
        final matchesConn =
            connLower == null ||
            item.sourceName.toLowerCase() == connLower ||
            item.destinationName.toLowerCase() == connLower ||
            item.sourceName.toLowerCase().contains(connLower) ||
            item.destinationName.toLowerCase().contains(connLower);
        if (item.status == FileTransferStatus.pending && matchesConn) {
          final updated = item.copyWith(
            status: FileTransferStatus.canceled,
            updatedAt: now,
          );
          await updateUseCase(history: updated);
          updatedList.add(updated);
        } else {
          updatedList.add(item);
        }
      }
      state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
        histories: updatedList,
      );
    } on Object catch (e, st) {
      log(
        'Failed to cancel all queued transfers',
        name: 'FileTransferHistoryController',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> clearCompleted({String? connection}) async {
    try {
      final deleteUseCase = ref.read(deleteFileTransferHistoryUseCaseProvider);
      final current = stateOrNull?.histories ?? [];
      final connLower = connection?.toLowerCase();
      final toDelete = current.where((item) {
        final isCompletedType =
            item.status == FileTransferStatus.completed ||
            item.status == FileTransferStatus.failed ||
            item.status == FileTransferStatus.canceled;
        final matchesConn =
            connLower == null ||
            item.sourceName.toLowerCase() == connLower ||
            item.destinationName.toLowerCase() == connLower ||
            item.sourceName.toLowerCase().contains(connLower) ||
            item.destinationName.toLowerCase().contains(connLower);
        return isCompletedType && matchesConn;
      }).toList();

      for (final item in toDelete) {
        await deleteUseCase(id: item.id);
      }
      final remaining = current
          .where((item) => !toDelete.contains(item))
          .toList();
      state = (stateOrNull ?? const FileTransferHistoryState()).copyWith(
        histories: remaining,
      );
    } on Object catch (e, st) {
      log(
        'Failed to clear completed transfers',
        name: 'FileTransferHistoryController',
        error: e,
        stackTrace: st,
      );
    }
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
