import 'dart:async';
import 'dart:developer';

import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:sharehop/core/repositories/connection/repository.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sharehop/infrastructures/repositories/connection/error.dart';
import 'package:sharehop/infrastructures/repositories/connection/factory.dart';
import 'package:sharehop/infrastructures/repositories/connection/mapper.dart';
import 'package:sqflite/sqflite.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  const new();

  @override
  Future<List<ConnectionModel>> getAll() async {
    log('Get all connections started', name: 'ConnectionRepositoryImpl.getAll');

    try {
      final db = await DatabaseManager.instance.database;
      final results = await db.query(ConnectionModel.tableName);

      log('Get all connections done', name: 'ConnectionRepositoryImpl.getAll');

      return results.map(ConnectionModel.fromJson).toList();
    } on Exception catch (e, st) {
      log(
        'Failed to get all connections',
        name: 'ConnectionRepositoryImpl.getAll',
        error: e,
        stackTrace: st,
      );
      throw GetConnectionFailedError();
    }
  }

  @override
  Future<ConnectionModel?> getOne(String id) async {
    log(
      'Get one connection started with id $id',
      name: 'ConnectionRepositoryImpl.getOne',
    );

    try {
      final db = await DatabaseManager.instance.database;
      final results = await db.query(
        ConnectionModel.tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      log(
        'Get one connection with id $id done',
        name: 'ConnectionRepositoryImpl.getOne',
      );

      return results.isNotEmpty
          ? ConnectionModel.fromJson(results.first)
          : null;
    } on Exception catch (e, st) {
      log(
        'Get on connection with id $id failed',
        name: 'ConnectionRepositoryImpl.getOne',
        error: e,
        stackTrace: st,
      );
      throw GetConnectionFailedError();
    }
  }

  @override
  Future<ConnectionModel> create(ConnectionDraftDto draft) async {
    log('Create connection started', name: 'ConnectionRepositoryImpl.create');

    try {
      final db = await DatabaseManager.instance.database;
      final model = buildConnectionDraftDtoFromConnectionModel(draft);
      await db.insert(
        ConnectionModel.tableName,
        model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      log('Create connection done', name: 'ConnectionRepositoryImpl.create');

      return model;
    } on Exception catch (e, st) {
      log(
        'Create connection failed',
        name: 'ConnectionRepositoryImpl.create',
        error: e,
        stackTrace: st,
      );
      throw CreateConnectionFailedError();
    }
  }

  @override
  Future<ConnectionModel?> update(ConnectionRevisionDto revision) async {
    log('Update connection started', name: 'ConnectionRepositoryImpl.update');

    if (await checkIfExists(revision.id) == null) {
      return null;
    }

    try {
      final db = await DatabaseManager.instance.database;
      final updateValues = mapConnectionRevisionDtoToUpdateValues(revision);
      await db.update(
        ConnectionModel.tableName,
        updateValues,
        where: 'id = ?',
        whereArgs: [revision.id],
      );

      log('Update connection done', name: 'ConnectionRepositoryImpl.update');

      return await getOne(revision.id);
    } on Exception catch (e, st) {
      log(
        'Update connection failed',
        name: 'ConnectionRepositoryImpl.update',
        error: e,
        stackTrace: st,
      );
      throw UpdateConnectionFailedError();
    }
  }

  @override
  Future<String?> checkIfExists(String id) async {
    log(
      'Check if exists started for id $id',
      name: 'ConnectionRepositoryImpl.checkIfExists',
    );

    try {
      final db = await DatabaseManager.instance.database;
      final results = await db.query(
        ConnectionModel.tableName,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: [id],
      );

      return results.isNotEmpty ? results.first['id']! as String : null;
    } on Exception catch (e, st) {
      log('Check if exists failed for id $id', error: e, stackTrace: st);
      throw GetConnectionFailedError();
    }
  }

  @override
  Future<void> remove(String id) async {
    log(
      'Remove connection started for id $id',
      name: 'ConnectionRepositoryImpl.remove',
    );

    try {
      final db = await DatabaseManager.instance.database;
      await db.delete(
        ConnectionModel.tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      log(
        'Remove connection done for id $id',
        name: 'ConnectionRepositoryImpl.remove',
      );
    } on Exception catch (e, st) {
      log('Remove connection failed for id $id', error: e, stackTrace: st);
      throw RemoveConnectionFailedError();
    }
  }

  @override
  Future<void> batchRemove(Set<String> ids) async {
    log(
      'Batch remove connections started for ids $ids',
      name: 'ConnectionRepositoryImpl.batchRemove',
    );

    try {
      final db = await DatabaseManager.instance.database;
      final batch = db.batch();
      for (final id in ids) {
        batch.delete(
          ConnectionModel.tableName,
          where: 'id = ?',
          whereArgs: [id],
        );
      }
      await batch.commit(noResult: true);

      log(
        'Batch remove connections done for ids $ids',
        name: 'ConnectionRepositoryImpl.batchRemove',
      );
    } on Exception catch (e, st) {
      log(
        'Batch remove connections failed for ids $ids',
        error: e,
        stackTrace: st,
      );
      throw RemoveConnectionFailedError();
    }
  }
}
