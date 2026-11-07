import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/presentation/extensions/enums/app_theme_extension.dart';

void main() {
  group('AppThemeExtension', () {
    test('resolves correct label for each theme', () {
      expect(AppTheme.light.label, 'Light');
      expect(AppTheme.dark.label, 'Dark');
      expect(AppTheme.system.label, 'System');
    });

    test('retains domain persistentValue', () {
      expect(AppTheme.light.persistentValue, 'light');
      expect(AppTheme.dark.persistentValue, 'dark');
      expect(AppTheme.system.persistentValue, 'system');
    });
  });
}
