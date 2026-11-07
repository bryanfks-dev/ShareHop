import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/presentation/utils/file_size_formatter.dart';

void main() {
  group('formatFileSize', () {
    test('returns "0 B" for 0 or negative bytes', () {
      expect(formatFileSize(bytes: 0), '0 B');
      expect(formatFileSize(bytes: -100), '0 B');
    });

    test('formats bytes correctly', () {
      expect(formatFileSize(bytes: 500), '500 B');
      expect(formatFileSize(bytes: 1), '1 B');
    });

    test('formats kilobytes correctly with single decimal or whole number', () {
      expect(formatFileSize(bytes: 1536), '1.5 KB');
      expect(formatFileSize(bytes: 10 * 1024), '10 KB');
      expect(formatFileSize(bytes: 50 * 1024), '50 KB');
    });

    test('formats megabytes correctly', () {
      expect(formatFileSize(bytes: (2.5 * 1024 * 1024).round()), '2.5 MB');
      expect(formatFileSize(bytes: 100 * 1024 * 1024), '100 MB');
    });

    test('formats gigabytes correctly', () {
      final fourPointTwoGb = (4.2 * 1024 * 1024 * 1024).round();
      expect(formatFileSize(bytes: fourPointTwoGb), '4.2 GB');
      expect(formatFileSize(bytes: 16 * 1024 * 1024 * 1024), '16 GB');
    });

    test('formats terabytes correctly', () {
      expect(
        formatFileSize(bytes: (1.5 * 1024 * 1024 * 1024 * 1024).round()),
        '1.5 TB',
      );
    });
  });
}
