import 'package:sharehop/core/enums/app_theme.dart';

extension AppThemeExtension on AppTheme {
  String get label {
    return switch (this) {
      AppTheme.light => 'Light',
      AppTheme.dark => 'Dark',
      AppTheme.system => 'System',
    };
  }
}
