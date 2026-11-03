import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/presentation/controllers/app_config_controller.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showChangeAppAppearanceSheet(BuildContext context) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) => _ChangeAppAppearanceSheetContent(),
  );
}

class _ChangeAppAppearanceSheetContent extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final appConfig = ref.watch(appConfigControllerProvider);
    final appConfigController = ref.watch(appConfigControllerProvider.notifier);

    final innerSelectedAppTheme = useState<AppTheme>(
      appConfig.value?.appAppearance ?? .system,
    );

    Future<void> handleOnPressTheme({required AppTheme newTheme}) async {
      innerSelectedAppTheme.value = newTheme;
      await appConfigController.setAppAppearance(theme: newTheme);
      if (context.mounted) {
        context.navigator.pop();
      }
    }

    void handleOnPressLight() => handleOnPressTheme(newTheme: .light);
    void handleOnPressDark() => handleOnPressTheme(newTheme: .dark);
    void handleOnPressSystem() => handleOnPressTheme(newTheme: .system);

    return Container(
      width: double.maxFinite,
      padding: .symmetric(
        vertical: 2 * theme.style.pagePadding.top,
        horizontal: theme.style.pagePadding.left,
      ),
      decoration: BoxDecoration(
        color: theme.colors.card,
        border: .all(color: theme.colors.border),
        borderRadius: theme.style.borderRadius.xl,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: Spacing.lg,
            children: [
              Text(
                'Select app appearance',
                style: theme.typography.display.sm.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w600,
                ),
              ),
              Column(
                mainAxisSize: .min,
                spacing: Spacing.md,
                children: [
                  _ChangeAppAppearanceSheetItem(
                    appTheme: .light,
                    value: innerSelectedAppTheme.value == .light,
                    onPress: handleOnPressLight,
                  ),
                  _ChangeAppAppearanceSheetItem(
                    appTheme: .dark,
                    value: innerSelectedAppTheme.value == .dark,
                    onPress: handleOnPressDark,
                  ),
                  _ChangeAppAppearanceSheetItem(
                    appTheme: .system,
                    value: innerSelectedAppTheme.value == .system,
                    onPress: handleOnPressSystem,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChangeAppAppearanceSheetItem extends StatelessWidget {
  const new({
    required this.appTheme,
    required this.onPress,
    this.value = false,
  });

  final AppTheme appTheme;
  final bool value;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnChange({required bool value}) {
      onPress();
    }

    return Container(
      padding: .all(theme.style.pagePadding.top),
      decoration: BoxDecoration(
        border: .all(color: value ? theme.colors.primary : theme.colors.border),
        borderRadius: theme.style.borderRadius.md,
      ),
      child: FRadio(
        label: Text(
          appTheme.label,
          style: theme.typography.body.xs.copyWith(
            color: theme.colors.foreground,
          ),
        ),
        value: value,
        onChange: (val) => handleOnChange(value: val),
      ),
    );
  }
}
