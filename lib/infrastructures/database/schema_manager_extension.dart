import 'package:flutter/services.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sqflite/sqflite.dart';

extension SchemaManager on DatabaseManager {
  static const String _kDatabaseSchemaFilePath = 'assets/database/schema.sql';

  Future<void> createDatabase({
    required Database db,
    required int version,
  }) async {
    final schemaFile = await rootBundle.loadString(_kDatabaseSchemaFilePath);
    await applySchema(db: db, schemaSql: schemaFile);
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
