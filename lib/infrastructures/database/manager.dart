import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  new _init();

  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _database;

  static const String _kDatabaseFilePath = 'sharehop.db';
  static const String _kDatabaseSchemaFilePath = 'assets/database/schema.sql';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    return await _initializeDatabase(_kDatabaseFilePath);
  }

  Future<Database> _initializeDatabase(String filePath) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    final schemaFile = await rootBundle.loadString(_kDatabaseSchemaFilePath);
    final statements = schemaFile.split(';').map((s) => s.trim());

    for (final statement in statements) {
      if (statement.isEmpty) {
        continue;
      }
      await db.execute(statement);
    }
  }

  Future<void> close() async {
    final database = await instance.database;
    await database.close();
  }
}
