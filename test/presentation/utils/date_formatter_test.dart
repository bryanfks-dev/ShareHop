import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/presentation/utils/date_formatter.dart';

void main() {
  group('formatTimeAgo', () {
    test('returns "Just Now" when difference is less than a minute', () {
      final now = DateTime.now();
      final date = now.subtract(const Duration(seconds: 30));

      expect(formatTimeAgo(date: date), 'Just Now');
    });

    test('returns "X mins ago" when difference is under an hour', () {
      final now = DateTime.now();
      final date = now.subtract(const Duration(minutes: 15));

      expect(formatTimeAgo(date: date), '15 mins ago');
    });

    test('returns "X hours ago" when difference is under a day', () {
      final now = DateTime.now();
      final date = now.subtract(const Duration(hours: 5));

      expect(formatTimeAgo(date: date), '5 hours ago');
    });

    test('returns "X days ago" when difference is under a week', () {
      final now = DateTime.now();
      final date = now.subtract(const Duration(days: 3));

      expect(formatTimeAgo(date: date), '3 days ago');
    });

    test('returns "X weeks ago" when difference is under 30 days', () {
      final now = DateTime.now();
      final date = now.subtract(const Duration(days: 14));

      expect(formatTimeAgo(date: date), '2 weeks ago');
    });

    test('returns "X months ago" when difference is under 365 days', () {
      final now = DateTime.now();
      final date = now.subtract(const Duration(days: 90));

      expect(formatTimeAgo(date: date), '3 months ago');
    });

    test('returns "X years ago" when difference is at least 365 days', () {
      final now = DateTime.now();
      final date = now.subtract(const Duration(days: 800));

      expect(formatTimeAgo(date: date), '2 years ago');
    });
  });
}
