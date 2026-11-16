import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/core/repositories/file_transfer_history_repository.dart';
import 'package:sharehop/core/use_cases/clear_file_transfer_history_use_case.dart';
import 'package:sharehop/core/use_cases/delete_file_transfer_history_use_case.dart';
import 'package:sharehop/core/use_cases/get_file_transfer_histories_use_case.dart';
import 'package:sharehop/core/use_cases/update_file_transfer_history_use_case.dart';
import 'package:uuid/uuid.dart';

class _FakeFileTransferHistoryRepository
    implements FileTransferHistoryRepository {
  final List<FileTransferHistoryModel> items = [];

  @override
  Future<List<FileTransferHistoryModel>> getAll({
    FileTransferStatus? status,
    String? searchQuery,
  }) async {
    return items.where((item) {
      if (status != null && item.status != status) return false;
      if (searchQuery != null &&
          !item.fileName.toLowerCase().contains(searchQuery.toLowerCase())) {
        return false;
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
  late _FakeFileTransferHistoryRepository repository;
  late GetFileTransferHistoriesUseCase getUseCase;
  late ClearFileTransferHistoryUseCase clearUseCase;
  late DeleteFileTransferHistoryUseCase deleteUseCase;

  final id1 = const Uuid().v4obj();
  final id2 = const Uuid().v4obj();
  final item1 = FileTransferHistoryModel(
    id: id1,
    fileName: 'report.pdf',
    fileSize: 100,
    fileMimeType: 'application/pdf',
    sourceName: 'A',
    destinationName: 'B',
    status: .completed,
    createdAt: .now(),
    updatedAt: .now(),
  );
  final item2 = FileTransferHistoryModel(
    id: id2,
    fileName: 'photo.jpg',
    fileSize: 200,
    fileMimeType: 'image/jpeg',
    sourceName: 'B',
    destinationName: 'C',
    status: .failed,
    createdAt: .now(),
    updatedAt: .now(),
  );

  setUp(() {
    repository = _FakeFileTransferHistoryRepository();
    repository.items.addAll([item1, item2]);
    getUseCase = GetFileTransferHistoriesUseCase(repository: repository);
    clearUseCase = ClearFileTransferHistoryUseCase(repository: repository);
    deleteUseCase = DeleteFileTransferHistoryUseCase(repository: repository);
  });

  group('FileTransferHistoryUseCases', () {
    test('UpdateFileTransferHistoryUseCase updates existing item', () async {
      final updateUseCase = UpdateFileTransferHistoryUseCase(
        repository: repository,
      );
      final updated = item1.copyWith(status: FileTransferStatus.canceled);
      await updateUseCase(history: updated);
      expect(repository.items.first.status, FileTransferStatus.canceled);
    });
    test(
      'GetFileTransferHistoriesUseCase retrieves items with filter',
      () async {
        final all = await getUseCase();
        expect(all.length, 2);

        final completed = await getUseCase(
          status: FileTransferStatus.completed,
        );
        expect(completed.length, 1);
        expect(completed.first.id, id1);

        final searched = await getUseCase(searchQuery: 'photo');
        expect(searched.length, 1);
        expect(searched.first.id, id2);
      },
    );

    test('DeleteFileTransferHistoryUseCase removes single item', () async {
      await deleteUseCase(id: id1);
      expect(repository.items.length, 1);
      expect(repository.items.first.id, id2);
    });

    test('ClearFileTransferHistoryUseCase removes all items', () async {
      await clearUseCase();
      expect(repository.items.isEmpty, isTrue);
    });
  });
}
