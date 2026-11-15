import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/core/repositories/file_transfer_history_repository.dart';
import 'package:sharehop/di/file_transfer_history_di.dart';
import 'package:sharehop/presentation/controllers/file_transfer_history_controller.dart';
import 'package:uuid/uuid.dart';

class FakeFileTransferHistoryRepository
    implements FileTransferHistoryRepository {
  new({List<FileTransferHistoryModel>? initial})
      : items = initial ?? [];

  final List<FileTransferHistoryModel> items;

  @override
  Future<List<FileTransferHistoryModel>> getAll({
    FileTransferStatus? status,
    String? searchQuery,
  }) async {
    return items.where((item) {
      if (status != null && item.status != status) return false;
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        if (!item.fileName.toLowerCase().contains(q) &&
            !item.sourceName.toLowerCase().contains(q) &&
            !item.destinationName.toLowerCase().contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  @override
  Future<FileTransferHistoryModel?> getById(UuidValue id) async {
    return items.where((e) => e.id == id).firstOrNull;
  }

  @override
  Future<void> insert(FileTransferHistoryModel history) async {
    items.add(history);
  }

  @override
  Future<void> update(FileTransferHistoryModel history) async {
    final idx = items.indexWhere((e) => e.id == history.id);
    if (idx != -1) items[idx] = history;
  }

  @override
  Future<void> delete(UuidValue id) async {
    items.removeWhere((e) => e.id == id);
  }

  @override
  Future<void> clearAll() async {
    items.clear();
  }
}

void main() {
  final id1 = const Uuid().v4obj();
  final id2 = const Uuid().v4obj();
  final item1 = FileTransferHistoryModel(
    id: id1,
    fileName: 'photo.png',
    fileSize: 1024,
    fileMimeType: 'image/png',
    sourceName: 'iPhone',
    destinationName: 'Mac',
    status: FileTransferStatus.completed,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  final item2 = FileTransferHistoryModel(
    id: id2,
    fileName: 'backup.tar',
    fileSize: 2048,
    fileMimeType: 'application/x-tar',
    sourceName: 'Server',
    destinationName: 'Local',
    status: FileTransferStatus.failed,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  late FakeFileTransferHistoryRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeFileTransferHistoryRepository(initial: [item1, item2]);
    container = ProviderContainer(
      overrides: [
        fileTransferHistoryRepositoryProvider.overrideWithValue(repository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('FileTransferHistoryController', () {
    test('initializes and loads all histories', () async {
      final controller = container.read(
        fileTransferHistoryControllerProvider.notifier,
      );
      await controller.refresh();

      final state = container.read(fileTransferHistoryControllerProvider);
      expect(state.histories.length, 2);
      expect(state.isLoading, isFalse);
    });

    test('filterByStatus updates filter and reloads', () async {
      final controller = container.read(
        fileTransferHistoryControllerProvider.notifier,
      );
      await controller.filterByStatus(FileTransferStatus.completed);

      final state = container.read(fileTransferHistoryControllerProvider);
      expect(state.selectedStatus, FileTransferStatus.completed);
      expect(state.histories.length, 1);
      expect(state.histories.first.id, id1);
    });

    test('setSearchQuery updates query and reloads', () async {
      final controller = container.read(
        fileTransferHistoryControllerProvider.notifier,
      );
      await controller.setSearchQuery('backup');

      final state = container.read(fileTransferHistoryControllerProvider);
      expect(state.searchQuery, 'backup');
      expect(state.histories.length, 1);
      expect(state.histories.first.id, id2);
    });

    test('deleteHistory removes item from repository and state', () async {
      final controller = container.read(
        fileTransferHistoryControllerProvider.notifier,
      );
      await controller.refresh();
      await controller.deleteHistory(id1);

      final state = container.read(fileTransferHistoryControllerProvider);
      expect(state.histories.length, 1);
      expect(state.histories.first.id, id2);
      expect(repository.items.length, 1);
    });

    test('clearHistory clears all records', () async {
      final controller = container.read(
        fileTransferHistoryControllerProvider.notifier,
      );
      await controller.refresh();
      await controller.clearHistory();

      final state = container.read(fileTransferHistoryControllerProvider);
      expect(state.histories.isEmpty, isTrue);
      expect(repository.items.isEmpty, isTrue);
    });
  });
}
