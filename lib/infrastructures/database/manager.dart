import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sharehop/infrastructures/database/schema_manager_extension.dart';
import 'package:sqflite/sqflite.dart';
// Development-only tool kept in dev_dependencies.
// ignore: depend_on_referenced_packages
import 'package:sqflite_dev/sqflite_dev.dart';

export 'package:sharehop/infrastructures/database/schema_manager_extension.dart';

class DatabaseManager {
  new _init();

  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _database;
  static Database? _databaseForTesting;
  static Future<Database>? _initFuture;

  static const String _kDatabaseFilePath = 'sharehop.db';
  static const int _kDatabaseVersion = 2;

  @visibleForTesting
  static bool wipeOnDevMode = true;

  Future<Database> get database => init();

  Future<Database> init({String? filePath}) async {
    if (_databaseForTesting != null) {
      return _databaseForTesting!;
    }
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _initFuture ??= _initializeDatabase(
      filePath: filePath ?? _kDatabaseFilePath,
    );
    _database = await _initFuture;

    if (kDebugMode) {
      WorkbenchHelper.autoEnable(
        _database!,
        webDebugPort: 5554,
        webDebugName: 'ShareHop',
      );
    }

    return _database!;
  }

  Future<Database> _initializeDatabase({required String filePath}) async {
    log('Initializing database at $filePath', name: 'DatabaseManager');
    final path = await _getDatabasePath(filePath: filePath);

    if (wipeOnDevMode && kDebugMode && filePath != inMemoryDatabasePath) {
      log(
        'Dev mode: wiping existing database at $path',
        name: 'DatabaseManager',
      );
      await deleteDatabase(path);
    }

    return await openDatabase(
      path,
      version: _kDatabaseVersion,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON;'),
      onCreate: (db, version) async =>
          await createDatabase(db: db, version: version),
      onUpgrade: (db, oldVersion, newVersion) async {
        log(
          'Upgrading database from $oldVersion to $newVersion',
          name: 'DatabaseManager',
        );
        await ensureSchemaCreated(db: db);
      },
      onOpen: (db) async => await ensureSchemaCreated(db: db),
    );
  }

  Future<String> _getDatabasePath({String? filePath}) async {
    final targetPath = filePath ?? _kDatabaseFilePath;
    if (targetPath == inMemoryDatabasePath || isAbsolute(targetPath)) {
      return targetPath;
    }
    final databasePath = await getDatabasesPath();
    return join(databasePath, targetPath);
  }

  Future<void> wipeDatabase({String? filePath}) async {
    final path = await _getDatabasePath(filePath: filePath);
    await close();
    await deleteDatabase(path);
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
    _databaseForTesting = null;
    _initFuture = null;
  }

  @visibleForTesting
  // ignore: avoid_setters_without_getters Getter already defined in database
  static set databaseForTesting(Database? db) {
    _databaseForTesting = db;
    _database = db;
    _initFuture = null;
  }
}
