import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('contains expected enum values and persistentValues', () {
      expect(AppTheme.values, [
        AppTheme.light,
        AppTheme.dark,
        AppTheme.system,
      ]);

      expect(AppTheme.light.persistentValue, 'light');
      expect(AppTheme.dark.persistentValue, 'dark');
      expect(AppTheme.system.persistentValue, 'system');
    });
  });
}
