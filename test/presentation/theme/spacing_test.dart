import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

void main() {
  group('Spacing', () {
    test('defines correct spacing scale', () {
      expect(Spacing.none, 0.0);
      expect(Spacing.dot, 1.0);
      expect(Spacing.xs3, 2.0);
      expect(Spacing.xs2, 4.0);
      expect(Spacing.xs, 6.0);
      expect(Spacing.sm, 8.0);
      expect(Spacing.md, 12.0);
      expect(Spacing.lg, 16.0);
      expect(Spacing.xl, 24.0);
    });
  });
}
