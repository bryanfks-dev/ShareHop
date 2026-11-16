import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/presentation/controllers/settings_controller.dart';
import 'package:sharehop/presentation/screens/settings/widgets/confirmation_biometric_lock_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/information_biometrics_unavailable_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/settings_section.dart';

class SecuritySection extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final appConfig = ref.watch(settingsControllerProvider);
    final appConfigController = ref.watch(settingsControllerProvider.notifier);

    Future<void> handleOnProceedEnableBiometricLock() async {
      try {
        final authenticated = await appConfigController.authenticateBiometric(
          localizedMessage: 'Authenticate to enable biometric lock',
        );

        if (!authenticated) {
          return;
        }

        await appConfigController.setIsBiometricLockEnabled(enabled: true);

        if (!context.mounted) {
          return;
        }

        showFToast(
          context: context,
          title: Text(
            'Biometric lock enabled',
            style: theme.typography.body.sm.copyWith(
              color: theme.colors.foreground,
            ),
          ),
        );
      } on Object {
        // If authentication is cancelled or errors, state remains unchanged
      }
    }

    Future<void> handleOnChangeBiometricLock({required bool value}) async {
      try {
        final isSupported = await appConfigController.checkBiometricSupported();
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
          final authenticated = await appConfigController.authenticateBiometric(
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

    final isBiometricLockEnabled =
        appConfig.value?.isBiometricLockEnabled ?? false;

    return SettingsSection(
      title: 'Security',
      children: [
        SettingsSectionTileWithSwitchSuffix(
          title: 'Biometric lock',
          subtitle: 'Require biometric authentication to open app',
          value: isBiometricLockEnabled,
          onChange: (val) => handleOnChangeBiometricLock(value: val),
        ),
      ],
    );
  }
}
