import 'dart:async';
import 'dart:developer';

import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/core/repositories/file_transfer_history_repository.dart';
import 'package:sharehop/data/mapper/file_transfer_history_mapper.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid_value.dart';

class FileTransferHistoryRepositoryImpl
    implements FileTransferHistoryRepository {
  const new({required this.mapper});

  final FileTransferHistoryMapper mapper;

  @override
  Future<List<FileTransferHistoryModel>> getAll({
    FileTransferStatus? status,
    String? searchQuery,
  }) async {
    log(
      'Get all file transfer histories started',
      name: 'FileTransferHistoryRepositoryImpl.getAll',
    );
    try {
      final db = await DatabaseManager.instance.database;

      final whereClauses = <String>[];
      final whereArgs = <Object?>[];

      if (status != null) {
        whereClauses.add('status = ?');
        whereArgs.add(status.persistentValue);
      }

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final query = '%${searchQuery.trim()}%';
        whereClauses.add(
          '(file_name LIKE ? OR source_name LIKE ? OR destination_name LIKE ?)',
        );
        whereArgs.addAll([query, query, query]);
      }

      final where = whereClauses.isNotEmpty
          ? whereClauses.join(' AND ')
          : null;

      final results = await db.query(
        FileTransferHistoryModel.tableName,
        where: where,
        whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
        orderBy: 'created_at DESC',
      );

      return results.map(mapper.toModel).toList();
    } on Exception catch (e, st) {
      log('Get all file transfer histories failed', error: e, stackTrace: st);
      return [];
    }
  }

  @override
  Future<FileTransferHistoryModel?> getById(UuidValue id) async {
    log(
      'Get file transfer history by ID started for $id',
      name: 'FileTransferHistoryRepositoryImpl.getById',
    );
    try {
      final db = await DatabaseManager.instance.database;
      final results = await db.query(
        FileTransferHistoryModel.tableName,
        where: 'id = ?',
        whereArgs: [id.uuid],
        limit: 1,
      );

      if (results.isEmpty) {
        return null;
      }
      return mapper.toModel(results.first);
    } on Exception catch (e, st) {
      log('Get file transfer history by ID failed', error: e, stackTrace: st);
      return null;
    }
  }

  @override
  Future<void> insert(FileTransferHistoryModel history) async {
    log(
      'Insert file transfer history started for id ${history.id}',
      name: 'FileTransferHistoryRepositoryImpl.insert',
    );
    try {
      final db = await DatabaseManager.instance.database;
      await db.insert(
        FileTransferHistoryModel.tableName,
        mapper.toRow(history),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on Exception catch (e, st) {
      log(
        'Insert file transfer history failed for id ${history.id}',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<void> update(FileTransferHistoryModel history) async {
    log(
      'Update file transfer history started for id ${history.id}',
      name: 'FileTransferHistoryRepositoryImpl.update',
    );
    try {
      final db = await DatabaseManager.instance.database;
      await db.update(
        FileTransferHistoryModel.tableName,
        mapper.toRow(history),
        where: 'id = ?',
        whereArgs: [history.id.uuid],
      );
    } on Exception catch (e, st) {
      log(
        'Update file transfer history failed for id ${history.id}',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<void> delete(UuidValue id) async {
    log(
      'Delete file transfer history started for id $id',
      name: 'FileTransferHistoryRepositoryImpl.delete',
    );
    try {
      final db = await DatabaseManager.instance.database;
      await db.delete(
        FileTransferHistoryModel.tableName,
        where: 'id = ?',
        whereArgs: [id.uuid],
      );
    } on Exception catch (e, st) {
      log(
        'Delete file transfer history failed for id $id',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<void> clearAll() async {
    log(
      'Clear all file transfer histories started',
      name: 'FileTransferHistoryRepositoryImpl.clearAll',
    );
    try {
      final db = await DatabaseManager.instance.database;
      await db.delete(FileTransferHistoryModel.tableName);
    } on Exception catch (e, st) {
      log('Clear all file transfer histories failed', error: e, stackTrace: st);
      rethrow;
    }
  }
}
