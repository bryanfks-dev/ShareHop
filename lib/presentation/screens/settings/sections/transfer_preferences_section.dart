import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/presentation/controllers/settings_controller.dart';
import 'package:sharehop/presentation/extensions/enums/file_conflicts_resolution_extension.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_on_file_conflicts_resolution_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_simultaneous_transfers_limit_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/settings_section.dart';

class TransferPreferencesSection extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(settingsControllerProvider);
    final appConfigController = ref.watch(settingsControllerProvider.notifier);

    Future<void> handleOnChangeWifiOnlyTransfers({required bool value}) async {
      await appConfigController.setIsWifiOnlyTransfersEnabled(enabled: value);
    }

    Future<void> handleOnPressSimultaneousTransfers() async =>
        await showChangeSimultaneousTransfersLimitSheet(context);

    Future<void> handleOnPressFileConflicts() async =>
        await showChangeOnFileConflictsResolutionSheet(context);

    final limit = appConfig.value?.simultaneousTransfersLimit ?? 3;

    return SettingsSection(
      title: 'Transfer Preferences',
      children: [
        SettingsSectionTileWithSwitchSuffix(
          title: 'Wi-Fi only transfers',
          value: appConfig.value?.isWifiOnlyTransfersEnabled ?? true,
          onChange: (value) => handleOnChangeWifiOnlyTransfers(value: value),
        ),
        SettingsSectionTileWithTextSuffix(
          onPress: handleOnPressSimultaneousTransfers,
          title: 'Simultaneous transfers',
          suffixText: '$limit ${limit == 1 ? 'transfer' : 'transfers'}',
        ),
        SettingsSectionTileWithTextSuffix(
          onPress: handleOnPressFileConflicts,
          title: 'File conflicts',
          suffixText:
              appConfig.value?.onFileConflictsResolution.label ??
              FileConflictsResolution.askeverytime.label,
        ),
      ],
    );
  }
}
