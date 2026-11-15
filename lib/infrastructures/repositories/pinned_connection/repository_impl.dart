import 'dart:async';
import 'dart:developer';

import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid_value.dart';

class PinnedConnectionRepositoryImpl implements PinnedConnectionRepository {
  const new();

  @override
  Future<List<PinnedConnectionModel>> getAll() async {
    log(
      'Get all pinned connections started',
      name: 'PinnedConnectionRepositoryImpl.getAll',
    );
    try {
      final db = await DatabaseManager.instance.database;
      final results = await db.query(PinnedConnectionModel.tableName);
      return results.map(PinnedConnectionModel.fromJson).toList();
    } on Exception catch (e, st) {
      log('Get all pinned connections failed', error: e, stackTrace: st);
      return [];
    }
  }

  @override
  Future<Set<UuidValue>> getPinnedConnectionIds() async {
    log(
      'Get pinned connection IDs started',
      name: 'PinnedConnectionRepositoryImpl.getPinnedConnectionIds',
    );
    try {
      final db = await DatabaseManager.instance.database;
      final results = await db.query(
        PinnedConnectionModel.tableName,
        columns: ['connection_id'],
      );
      return results
          .map((row) => UuidValue.fromString(row['connection_id']! as String))
          .toSet();
    } on Exception catch (e, st) {
      log('Get pinned connection IDs failed', error: e, stackTrace: st);
      return {};
    }
  }

  @override
  Future<void> pin(UuidValue connectionId) async {
    log(
      'Pin connection started for id $connectionId',
      name: 'PinnedConnectionRepositoryImpl.pin',
    );
    try {
      final db = await DatabaseManager.instance.database;
      final now = DateTime.now().toUtc();
      await db.insert(
        PinnedConnectionModel.tableName,
        {
          'connection_id': connectionId.uuid,
          'created_at': now.toIso8601String(),
          'updated_at': now.toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on Exception catch (e, st) {
      log(
        'Pin connection failed for id $connectionId',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<void> unpin(UuidValue connectionId) async {
    log(
      'Unpin connection started for id $connectionId',
      name: 'PinnedConnectionRepositoryImpl.unpin',
    );
    try {
      final db = await DatabaseManager.instance.database;
      await db.delete(
        PinnedConnectionModel.tableName,
        where: 'connection_id = ?',
        whereArgs: [connectionId.uuid],
      );
    } on Exception catch (e, st) {
      log(
        'Unpin connection failed for id $connectionId',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
