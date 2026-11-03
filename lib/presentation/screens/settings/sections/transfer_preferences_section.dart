import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/on_file_conflicts_resolution.dart';
import 'package:sharehop/presentation/controllers/app_config_controller.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_on_file_conflicts_resolution_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_simultaneous_transfers_limit_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/settings_section.dart';

class TransferPreferencesSection extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(appConfigControllerProvider);
    final appConfigController = ref.watch(appConfigControllerProvider.notifier);

    Future<void> handleOnChangeWifiOnlyTransfers({required bool value}) async {
      await appConfigController.setIsWifiOnlyTransfersEnabled(enabled: value);
    }

    Future<void> handleOnChangeBackgroundTransfers({
      required bool value,
    }) async {
      await appConfigController.setIsBackgroundTransfersEnabled(enabled: value);
    }

    Future<void> handleOnPressSimultaneousTransfers() async =>
        await showChangeSimultaneousTransfersLimitSheet(context);

    Future<void> handleOnPressFileConflicts() async =>
        await showChangeOnFileConflictsResolutionSheet(context);

    final limit = appConfig.value?.simultaneousTransfersLimit ?? 3;

    return SettingsSection(
      title: 'TRANSFER PREFERENCES',
      children: [
        SettingsSectionTileWithSwitchSuffix(
          title: 'Wi-Fi only transfers',
          value: appConfig.value?.isWifiOnlyTransfersEnabled ?? true,
          onChange: (value) => handleOnChangeWifiOnlyTransfers(value: value),
        ),
        SettingsSectionTileWithSwitchSuffix(
          title: 'Background transfers',
          value: appConfig.value?.isBackgroundTransfersEnabled ?? true,
          onChange: (value) => handleOnChangeBackgroundTransfers(value: value),
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
              OnFileConflictsResolution.askeverytime.label,
        ),
      ],
    );
  }
}
