import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/presentation/controllers/app_config_controller.dart';
import 'package:sharehop/presentation/screens/settings/widgets/confirmation_biometric_lock_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/information_biometrics_unavailable_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/settings_section.dart';

class SecuritySection extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(appConfigControllerProvider);
    final appConfigController = ref.watch(appConfigControllerProvider.notifier);
    final biometricService = ref.watch(biometricLockServiceProvider);

    Future<void> handleOnProceedEnableBiometricLock() async {
      try {
        final authenticated = await biometricService.authenticateUser(
          localizedMessage: 'Authenticate to enable biometric lock',
        );

        if (authenticated) {
          await appConfigController.setIsBiometricLockEnabled(enabled: true);
        }
      } on Object {
        // If authentication is cancelled or errors, state remains unchanged
      }
    }

    Future<void> handleOnChangeBiometricLock({required bool value}) async {
      try {
        final isSupported = await biometricService.checkDeviceSupported();
        if (!context.mounted) {
          return;
        }

        if (!isSupported) {
          await showInformationBiometricsUnavailableSheet(context);
          return;
        }

        if (value) {
          await showConfirmationBiometricLockSheet(
            context,
            onProceed: handleOnProceedEnableBiometricLock,
          );
        } else {
          final authenticated = await biometricService.authenticateUser(
            localizedMessage: 'Authenticate to disable biometric lock',
          );

          if (authenticated) {
            await appConfigController.setIsBiometricLockEnabled(enabled: false);
          }
        }
      } on Object {
        // If authentication is cancelled or errors, state remains unchanged
      }
    }

    return SettingsSection(
      title: 'SECURITY',
      children: [
        SettingsSectionTileWithSwitchSuffix(
          title: 'Biometric lock',
          value: appConfig.value?.isBiometricLockEnabled ?? false,
          onChange: (value) => handleOnChangeBiometricLock(value: value),
        ),
      ],
    );
  }
}
