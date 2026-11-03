import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showConfirmationBiometricLockSheet(
  BuildContext context, {
  required VoidCallback onProceed,
}) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) =>
        _ConfirmationBiometricLockSheetContent(onProceed: onProceed),
  );
}

class _ConfirmationBiometricLockSheetContent extends StatelessWidget {
  const new({required this.onProceed});

  final VoidCallback onProceed;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressCancel() {
      context.navigator.pop();
    }

    void handleOnPressProceed() {
      context.navigator.pop();
      onProceed();
    }

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
                'Biometric Lock',
                style: theme.typography.display.sm.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w600,
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/images/biometric_lock_illustration.svg',
                  height: 120,
                ),
              ),
              Text(
                'Protect your connections and transferred files by requiring '
                'biometric authentication (Face ID, Touch ID, or fingerprint) '
                'each time you open ShareHop.',
                style: theme.typography.body.xs.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              Row(
                mainAxisAlignment: .end,
                spacing: Spacing.md,
                children: [
                  FButton(
                    variant: .outline,
                    size: .sm,
                    onPress: handleOnPressCancel,
                    child: const Text('Cancel'),
                  ),
                  FButton(
                    size: .sm,
                    onPress: handleOnPressProceed,
                    child: const Text('Proceed'),
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
