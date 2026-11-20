import 'dart:developer';
import 'dart:io';

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
  static const int _kWebDebugPort = 5554;

  static bool wipeOnDevMode = true;

  static bool enableWorkbench = true;

  Future<Database> get database => init();

  Future<Database> init({
    String? filePath,
    bool? enableWorkbench,
  }) async {
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

    final shouldEnableWorkbench =
        enableWorkbench ?? DatabaseManager.enableWorkbench;

    if (!kIsWeb && kDebugMode && shouldEnableWorkbench) {
      await _enableWorkbenchSafely(db: _database!);
    }

    return _database!;
  }

  Future<void> _enableWorkbenchSafely({required Database db}) async {
    final isPortAvailable = WorkbenchServer.instance.isRunning ||
        await _isPortAvailable(port: _kWebDebugPort);
    if (!isPortAvailable) {
      log(
        'sqflite_dev: Port $_kWebDebugPort is already in use. '
        'Skipping workbench server.',
        name: 'DatabaseManager',
      );
      return;
    }

    try {
      WorkbenchHelper.autoEnable(
        db,
        webDebugPort: _kWebDebugPort,
        webDebugName: 'ShareHop',
      );
    } on Object catch (e) {
      log(
        'sqflite_dev: Failed to enable workbench: $e',
        name: 'DatabaseManager',
      );
    }
  }

  static Future<bool> _isPortAvailable({required int port}) async {
    try {
      final socket = await ServerSocket.bind(
        InternetAddress.anyIPv4,
        port,
      );
      await socket.close();
      return true;
    } on Object {
      return false;
    }
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
