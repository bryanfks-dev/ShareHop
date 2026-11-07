import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/data/dto/storage_status_dto.dart';

void main() {
  group('StorageStatusDto', () {
    test('calculates usedBytes correctly', () {
      const status = StorageStatusDto(
        totalBytes: 1000,
        freeBytes: 400,
      );

      expect(status.usedBytes, 600);
    });

    test('returns 0 usedBytes when freeBytes exceeds or equals totalBytes', () {
      const status = StorageStatusDto(
        totalBytes: 500,
        freeBytes: 600,
      );

      expect(status.usedBytes, 0);
    });

    test('calculates usedPercentage correctly', () {
      const status = StorageStatusDto(
        totalBytes: 1000,
        freeBytes: 250,
      );

      expect(status.usedPercentage, 0.75);
    });

    test('returns 0 usedPercentage when totalBytes is 0 or negative', () {
      const zero = StorageStatusDto(totalBytes: 0, freeBytes: 0);
      const negative = StorageStatusDto(totalBytes: -100, freeBytes: 50);

      expect(zero.usedPercentage, 0.0);
      expect(negative.usedPercentage, 0.0);
    });

    test('formatBytes formats various sizes correctly', () {
      expect(StorageStatusDto.formatBytes(bytes: 0), '0 B');
      expect(StorageStatusDto.formatBytes(bytes: -10), '0 B');
      expect(StorageStatusDto.formatBytes(bytes: 512), '512 B');
      expect(StorageStatusDto.formatBytes(bytes: 4096), '4.0 KB');
      expect(StorageStatusDto.formatBytes(bytes: 1024 * 1024), '1.0 MB');
      expect(StorageStatusDto.formatBytes(bytes: 10 * 1024 * 1024), '10 MB');
      expect(StorageStatusDto.formatBytes(bytes: 1024 * 1024 * 1024), '1.0 GB');
      expect(
        StorageStatusDto.formatBytes(bytes: 1024 * 1024 * 1024 * 1024),
        '1.0 TB',
      );
    });
  });
}
