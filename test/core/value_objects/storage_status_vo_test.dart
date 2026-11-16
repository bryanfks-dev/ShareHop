import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/value_objects/storage_status_vo.dart';

void main() {
  group('StorageStatusVO', () {
    test('calculates free capacity and used percentage correctly', () {
      const storage = StorageStatusVO(maximumCapacity: 1000, usedCapacity: 250);

      expect(storage.maximumCapacity, 1000);
      expect(storage.usedCapacity, 250);
      expect(storage.freeCapacity, 750);
    });

    test('supports zero usage', () {
      const storage = StorageStatusVO(maximumCapacity: 500, usedCapacity: 0);

      expect(storage.freeCapacity, 500);
    });

    test('supports full capacity usage', () {
      const storage = StorageStatusVO(maximumCapacity: 500, usedCapacity: 500);

      expect(storage.freeCapacity, 0);
    });
  });
}
