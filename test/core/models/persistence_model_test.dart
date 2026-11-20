import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/models/persistence_model.dart';

void main() {
  test('PersistenceModel.tableName throws UnimplementedError', () {
    expect(() => PersistenceModel.tableName, throwsUnimplementedError);
  });
}
