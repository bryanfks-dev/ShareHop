import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/data/mapper/file_transfer_history_mapper.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sharehop/infrastructures/repositories/file_transfer_history/repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;
  late FileTransferHistoryRepositoryImpl repository;
  const mapper = FileTransferHistoryMapper();

  setUp(() async {
    db = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        final schemaFile = await File('assets/database/schema.sql')
            .readAsString();
        await DatabaseManager.instance.applySchema(
          db: db,
          schemaSql: schemaFile,
        );
      },
    );
    DatabaseManager.databaseForTesting = db;
    repository = const FileTransferHistoryRepositoryImpl(mapper: mapper);
  });

  tearDown(() async {
    await db.close();
    DatabaseManager.databaseForTesting = null;
  });

  group('FileTransferHistoryRepositoryImpl', () {
    test('insert, getById, and getAll work correctly', () async {
      final id = const Uuid().v4obj();
      final history = FileTransferHistoryModel(
        id: id,
        fileName: 'photo.jpg',
        fileSize: 4096,
        fileMimeType: 'image/jpeg',
        sourceName: 'MacBook',
        destinationName: 'Synology NAS',
        status: FileTransferStatus.completed,
        createdAt: DateTime.utc(2026, 11, 15, 10),
        updatedAt: DateTime.utc(2026, 11, 15, 10),
      );

      await repository.insert(history);

      final fetched = await repository.getById(id);
      expect(fetched, isNotNull);
      expect(fetched!.fileName, 'photo.jpg');
      expect(fetched.status, FileTransferStatus.completed);

      final all = await repository.getAll();
      expect(all.length, 1);
      expect(all.first.id, id);
    });

    test('getAll filters by status and searchQuery', () async {
      final id1 = const Uuid().v4obj();
      final id2 = const Uuid().v4obj();

      await repository.insert(
        FileTransferHistoryModel(
          id: id1,
          fileName: 'budget.xlsx',
          fileSize: 1024,
          fileMimeType: 'application/vnd.ms-excel',
          sourceName: 'Finance Mac',
          destinationName: 'Cloud Server',
          status: FileTransferStatus.completed,
          createdAt: DateTime.utc(2026, 11, 15, 9),
          updatedAt: DateTime.utc(2026, 11, 15, 9),
        ),
      );

      await repository.insert(
        FileTransferHistoryModel(
          id: id2,
          fileName: 'presentation.pptx',
          fileSize: 8192,
          fileMimeType: 'application/vnd.ms-powerpoint',
          sourceName: 'Laptop',
          destinationName: 'FTP Share',
          status: FileTransferStatus.failed,
          createdAt: DateTime.utc(2026, 11, 15, 11),
          updatedAt: DateTime.utc(2026, 11, 15, 11),
        ),
      );

      // Filter by status
      final completed = await repository.getAll(
        status: FileTransferStatus.completed,
      );
      expect(completed.length, 1);
      expect(completed.first.fileName, 'budget.xlsx');

      final failed = await repository.getAll(status: FileTransferStatus.failed);
      expect(failed.length, 1);
      expect(failed.first.fileName, 'presentation.pptx');

      // Filter by search query
      final searched = await repository.getAll(searchQuery: 'budget');
      expect(searched.length, 1);
      expect(searched.first.id, id1);

      // Search by source name
      final searchedBySource = await repository.getAll(searchQuery: 'Laptop');
      expect(searchedBySource.length, 1);
      expect(searchedBySource.first.id, id2);
    });

    test('update and delete work correctly', () async {
      final id = const Uuid().v4obj();
      final history = FileTransferHistoryModel(
        id: id,
        fileName: 'archive.zip',
        fileSize: 20000,
        fileMimeType: 'application/zip',
        sourceName: 'Server A',
        destinationName: 'Server B',
        status: FileTransferStatus.inProgress,
        createdAt: DateTime.utc(2026, 11, 15, 8),
        updatedAt: DateTime.utc(2026, 11, 15, 8),
      );

      await repository.insert(history);

      final updated = history.copyWith(
        status: FileTransferStatus.completed,
        updatedAt: DateTime.utc(2026, 11, 15, 8, 5),
      );
      await repository.update(updated);

      final fetched = await repository.getById(id);
      expect(fetched!.status, FileTransferStatus.completed);

      await repository.delete(id);
      expect(await repository.getById(id), isNull);
    });

    test('clearAll removes all records', () async {
      await repository.insert(
        FileTransferHistoryModel(
          id: const Uuid().v4obj(),
          fileName: 'file1.txt',
          fileSize: 10,
          fileMimeType: 'text/plain',
          sourceName: 'A',
          destinationName: 'B',
          status: FileTransferStatus.completed,
          createdAt: DateTime.utc(2026, 11, 15, 7),
          updatedAt: DateTime.utc(2026, 11, 15, 7),
        ),
      );

      expect((await repository.getAll()).length, 1);
      await repository.clearAll();
      expect((await repository.getAll()).isEmpty, isTrue);
    });
  });
}
