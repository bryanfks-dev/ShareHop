import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/value_objects/storage_status_vo.dart';
import 'package:sharehop/presentation/view_models/storage_status_view_model.dart';

void main() {
  group('StorageStatusViewModel', () {
    test('instantiates with required properties and defaults updatedAt', () {
      final before = DateTime.now();
      final model = StorageStatusViewModel(
        maximumCapacity: 1000,
        usedCapacity: 400,
      );
      final after = DateTime.now();

      expect(model.maximumCapacity, 1000.0);
      expect(model.usedCapacity, 400.0);
      expect(model.freeCapacity, 600.0);
      expect(model.usedPercentage, 0.4);
      expect(model.totalBytes, 1000);
      expect(model.usedBytes, 400);
      expect(model.freeBytes, 600);
      expect(
        model.updatedAt.isAfter(before.subtract(const Duration(seconds: 1))),
        isTrue,
      );
      expect(
        model.updatedAt.isBefore(after.add(const Duration(seconds: 1))),
        isTrue,
      );
    });

    test('accepts custom updatedAt', () {
      final customDate = DateTime(2026);
      final model = StorageStatusViewModel(
        maximumCapacity: 500,
        usedCapacity: 100,
        updatedAt: customDate,
      );

      expect(model.updatedAt, customDate);
    });

    test('creates from StorageStatusVO via fromVO', () {
      const vo = StorageStatusVO(
        maximumCapacity: 2048,
        usedCapacity: 1024,
      );
      final customDate = DateTime(2026, 2);
      final model = StorageStatusViewModel.fromVO(vo, updatedAt: customDate);

      expect(model.maximumCapacity, 2048.0);
      expect(model.usedCapacity, 1024.0);
      expect(model.freeCapacity, 1024.0);
      expect(model.usedPercentage, 0.5);
      expect(model.updatedAt, customDate);
    });

    test('handles zero maximum capacity safely', () {
      final model = StorageStatusViewModel(
        maximumCapacity: 0,
        usedCapacity: 0,
      );

      expect(model.freeCapacity, 0.0);
      expect(model.usedPercentage, 0.0);
    });

    test('formatBytes formats byte sizes correctly', () {
      expect(StorageStatusViewModel.formatBytes(bytes: 0), '0 B');
      expect(StorageStatusViewModel.formatBytes(bytes: 1024), '1.0 KB');
      expect(
        StorageStatusViewModel.formatBytes(bytes: 1024 * 1024 * 500),
        '500 MB',
      );
    });
  });
}
