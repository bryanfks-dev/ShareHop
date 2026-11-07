import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;

  setUp(() async {
    db = await openDatabase(inMemoryDatabasePath);
  });

  tearDown(() async {
    await db.close();
  });

  group('SchemaManager', () {
    test('applySchema executes SQL statements correctly', () async {
      const sql = '''
        CREATE TABLE test_table (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL
        );
        INSERT INTO test_table (id, name) VALUES ('1', 'ShareHop');
      ''';

      await DatabaseManager.instance.applySchema(
        db: db,
        schemaSql: sql,
      );

      final rows = await db.query('test_table');
      expect(rows, hasLength(1));
      expect(rows.first['id'], '1');
      expect(rows.first['name'], 'ShareHop');
    });

    test('applySchema skips empty statements safely', () async {
      const sql = ' ; ; ; ';

      await expectLater(
        DatabaseManager.instance.applySchema(
          db: db,
          schemaSql: sql,
        ),
        completes,
      );
    });
  });
}
