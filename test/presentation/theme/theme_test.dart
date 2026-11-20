import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  group('Theme Tokens', () {
    test('lightTheme has light brightness and valid colors', () {
      expect(lightTheme.colors.brightness, Brightness.light);
      expect(lightTheme.colors.primary, isNotNull);
      expect(lightTheme.colors.app.success, isNotNull);
      expect(lightTheme.colors.app.accentBlue, isNotNull);
    });

    test('darkTheme has dark brightness and valid colors', () {
      expect(darkTheme.colors.brightness, Brightness.dark);
      expect(darkTheme.colors.primary, isNotNull);
      expect(darkTheme.colors.app.success, isNotNull);
      expect(darkTheme.colors.app.accentBlue, isNotNull);
    });

    test('typography definitions exist', () {
      expect(lightTheme.typography.body.sm, isNotNull);
      expect(darkTheme.typography.body.sm, isNotNull);
    });
  });
}
