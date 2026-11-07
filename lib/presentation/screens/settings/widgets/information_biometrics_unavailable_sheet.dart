import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showInformationBiometricsUnavailableSheet(
  BuildContext context,
) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) =>
        const _InformationBiometricsUnavailableSheetContent(),
  );
}

class _InformationBiometricsUnavailableSheetContent extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressDismiss() {
      context.navigator.pop();
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
                'Biometrics Unavailable',
                style: theme.typography.display.sm.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w600,
                ),
              ),
              Text(
                'Biometric authentication is not supported or not enrolled on '
                'this device.',
                style: theme.typography.body.xs.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              Row(
                mainAxisAlignment: .end,
                children: [
                  FButton(
                    size: .sm,
                    onPress: handleOnPressDismiss,
                    child: const Text('OK'),
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
