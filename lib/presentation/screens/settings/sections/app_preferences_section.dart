import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/presentation/controllers/app_config_controller.dart';
import 'package:sharehop/presentation/extensions/enums/app_theme_extension.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_app_appearance_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/settings_section.dart';

class AppPreferencesSection extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(appConfigControllerProvider);

    Future<void> handleOnPressAppearance() async {
      await showChangeAppAppearanceSheet(context);
    }

    return SettingsSection(
      title: 'APP PREFERENCES',
      children: [
        SettingsSectionTileWithTextSuffix(
          title: 'Appearance',
          suffixText: appConfig.value?.appAppearance.label ?? 'System',
          onPress: handleOnPressAppearance,
        ),
      ],
    );
  }
}
