import 'dart:async';
import 'dart:developer';

import 'package:sharehop/core/errors/connection.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid_value.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  const new({required this.connectionMapper});

  final ConnectionMapper connectionMapper;

  @override
  Future<List<ConnectionModel>> getAll() async {
    log('Get all connections started', name: 'ConnectionRepositoryImpl.getAll');

    try {
      final db = await DatabaseManager.instance.database;
      final results = await db.rawQuery('''
        SELECT
          c.id,
          c.protocol,
          c.display_name,
          c.remote_address,
          c.username,
          c.password_id,
          c.root_path,
          c.allow_self_signed_certificate,
          c.created_at,
          c.updated_at,
          ev.id AS ev_id,
          ev.salt AS ev_salt,
          ev.nonce AS ev_nonce,
          ev.cipher_text AS ev_cipher_text,
          ev.mac AS ev_mac,
          ev.created_at AS ev_created_at,
          ev.updated_at AS ev_updated_at
        FROM ${ConnectionModel.tableName} c
        LEFT JOIN ${EncryptedValueModel.tableName} ev ON c.password_id = ev.id
      ''');

      final connections = results
          .map(connectionMapper.toConnectionModel)
          .toList();

      log('Get all connections done', name: 'ConnectionRepositoryImpl.getAll');

      return connections;
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
  Future<ConnectionModel?> getOne(UuidValue id) async {
    log(
      'Get one connection started with id $id',
      name: 'ConnectionRepositoryImpl.getOne',
    );

    try {
      final db = await DatabaseManager.instance.database;
      final results = await db.rawQuery(
        '''
        SELECT
          c.id,
          c.protocol,
          c.display_name,
          c.remote_address,
          c.username,
          c.password_id,
          c.root_path,
          c.allow_self_signed_certificate,
          c.created_at,
          c.updated_at,
          ev.id AS ev_id,
          ev.salt AS ev_salt,
          ev.nonce AS ev_nonce,
          ev.cipher_text AS ev_cipher_text,
          ev.mac AS ev_mac,
          ev.created_at AS ev_created_at,
          ev.updated_at AS ev_updated_at
        FROM ${ConnectionModel.tableName} c
        LEFT JOIN ${EncryptedValueModel.tableName} ev ON c.password_id = ev.id
        WHERE c.id = ?
      ''',
        [id.uuid],
      );

      if (results.isEmpty) {
        return null;
      }

      final model = connectionMapper.toConnectionModel(results.first);

      log(
        'Get one connection with id $id done',
        name: 'ConnectionRepositoryImpl.getOne',
      );

      return model;
    } on Exception catch (e, st) {
      log(
        'Get one connection with id $id failed',
        name: 'ConnectionRepositoryImpl.getOne',
        error: e,
        stackTrace: st,
      );
      throw GetConnectionFailedError();
    }
  }

  @override
  Future<ConnectionModel> create(ConnectionModel connection) async {
    log('Create connection started', name: 'ConnectionRepositoryImpl.create');

    try {
      final db = await DatabaseManager.instance.database;
      await db.transaction((txn) async {
        if (connection.password != null) {
          await txn.insert(
            EncryptedValueModel.tableName,
            connection.password!.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await txn.insert(
          ConnectionModel.tableName,
          connection.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });

      log('Create connection done', name: 'ConnectionRepositoryImpl.create');

      return connection;
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
  Future<ConnectionModel?> update(ConnectionModel connection) async {
    log(
      'Update connection started with id ${connection.id}',
      name: 'ConnectionRepositoryImpl.update',
    );

    final existing = await getOne(connection.id);
    if (existing == null) {
      return null;
    }

    try {
      final db = await DatabaseManager.instance.database;

      await db.transaction((txn) async {
        if (connection.password != null) {
          await txn.insert(
            EncryptedValueModel.tableName,
            connection.password!.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }

        await txn.update(
          ConnectionModel.tableName,
          connection.toJson(),
          where: 'id = ?',
          whereArgs: [connection.id.uuid],
        );
      });

      log(
        'Update connection with id ${connection.id} done',
        name: 'ConnectionRepositoryImpl.update',
      );

      return await getOne(connection.id);
    } on Exception catch (e, st) {
      log(
        'Update connection with id ${connection.id} failed',
        name: 'ConnectionRepositoryImpl.update',
        error: e,
        stackTrace: st,
      );
      throw UpdateConnectionFailedError();
    }
  }

  @override
  Future<void> remove(UuidValue id) async {
    log(
      'Remove connection started for id $id',
      name: 'ConnectionRepositoryImpl.remove',
    );

    try {
      final db = await DatabaseManager.instance.database;
      await db.transaction((txn) async {
        final results = await txn.query(
          ConnectionModel.tableName,
          columns: ['password_id'],
          where: 'id = ?',
          whereArgs: [id.uuid],
        );
        if (results.isNotEmpty) {
          final passwordId = results.first['password_id'] as String?;
          if (passwordId != null && passwordId.isNotEmpty) {
            await txn.delete(
              EncryptedValueModel.tableName,
              where: 'id = ?',
              whereArgs: [passwordId],
            );
          }
        }
        await txn.delete(
          ConnectionModel.tableName,
          where: 'id = ?',
          whereArgs: [id.uuid],
        );
      });

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
  Future<void> batchRemove(Set<UuidValue> ids) async {
    log(
      'Batch remove connections started for ids $ids',
      name: 'ConnectionRepositoryImpl.batchRemove',
    );

    if (ids.isEmpty) {
      return;
    }

    try {
      final db = await DatabaseManager.instance.database;
      final batch = db.batch();
      for (final id in ids) {
        final results = await db.query(
          ConnectionModel.tableName,
          columns: ['password_id'],
          where: 'id = ?',
          whereArgs: [id.uuid],
        );
        if (results.isNotEmpty) {
          final passwordId = results.first['password_id'] as String?;
          if (passwordId != null && passwordId.isNotEmpty) {
            batch.delete(
              EncryptedValueModel.tableName,
              where: 'id = ?',
              whereArgs: [passwordId],
            );
          }
        }
        batch.delete(
          ConnectionModel.tableName,
          where: 'id = ?',
          whereArgs: [id.uuid],
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

  @override
  Future<Set<UuidValue>> checkIfExists(Set<UuidValue> ids) async {
    log(
      'Check if exists started for ids $ids',
      name: 'ConnectionRepositoryImpl.checkIfExists',
    );

    if (ids.isEmpty) {
      return {};
    }

    try {
      final db = await DatabaseManager.instance.database;
      final placeholders = List.filled(ids.length, '?').join(', ');
      final results = await db.query(
        ConnectionModel.tableName,
        columns: ['id'],
        where: 'id IN ($placeholders)',
        whereArgs: ids.map((id) => id.uuid).toList(),
      );

      final foundIds = results
          .map((row) => UuidValue.fromString(row['id']! as String))
          .toSet();

      log(
        'Check if exists done for ids $ids',
        name: 'ConnectionRepositoryImpl.checkIfExists',
      );

      return foundIds;
    } on Exception catch (e, st) {
      log('Check if exists failed for ids $ids', error: e, stackTrace: st);
      throw GetConnectionFailedError();
    }
  }
}
