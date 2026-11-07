import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sharehop/infrastructures/database/schema_manager_extension.dart';
import 'package:sqflite/sqflite.dart';

export 'package:sharehop/infrastructures/database/schema_manager_extension.dart';

class DatabaseManager {
  new _init();

  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _database;

  static const String _kDatabaseFilePath = 'sharehop.db';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    return await _initializeDatabase(filePath: _kDatabaseFilePath);
  }

  Future<Database> _initializeDatabase({required String filePath}) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async =>
          await createDatabase(db: db, version: version),
    );
  }

  Future<void> close() async {
    if (_database == null) {
      return;
    }
    await _database!.close();
    _database = null;
  }

  @visibleForTesting
  // ignore: avoid_setters_without_getters Getter already defined in database
  static set databaseForTesting(Database? db) {
    _database = db;
  }
}
