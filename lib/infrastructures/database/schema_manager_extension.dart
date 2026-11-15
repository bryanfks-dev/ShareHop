import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sqflite/sqflite.dart';

extension SchemaManager on DatabaseManager {
  static const String _kDatabaseSchemaFilePath = 'assets/database/schema.sql';

  Future<String> loadSchemaSql({String? filePath}) async {
    final path = filePath ?? _kDatabaseSchemaFilePath;
    try {
      return await rootBundle.loadString(path);
    } on Object catch (_) {
      final file = File(path);
      if (file.existsSync()) {
        return await file.readAsString();
      }
      rethrow;
    }
  }

  Future<void> createDatabase({
    required Database db,
    required int version,
  }) async {
    log('Creating database schema...', name: 'SchemaManager');
    final schemaSql = await loadSchemaSql();
    await applySchema(db: db, schemaSql: schemaSql);
    log('Database schema created successfully', name: 'SchemaManager');
  }

  Future<void> ensureSchemaCreated({required Database db}) async {
    log('Ensuring all schema tables exist...', name: 'SchemaManager');
    final schemaSql = await loadSchemaSql();
    await applySchema(db: db, schemaSql: schemaSql);
    log('Schema verification complete', name: 'SchemaManager');
  }

  Future<void> applySchema({
    required Database db,
    required String schemaSql,
  }) async {
    final statements = schemaSql.split(';').map((s) => s.trim());

    for (final statement in statements) {
      if (statement.isEmpty) {
        continue;
      }
      await db.execute(statement);
    }
  }
}
