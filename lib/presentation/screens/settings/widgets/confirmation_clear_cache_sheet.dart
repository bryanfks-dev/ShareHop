import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showConfirmationClearCacheSheet(
  BuildContext context, {
  required VoidCallback onConfirm,
}) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) =>
        _ConfirmationClearCacheSheetContent(onConfirm: onConfirm),
  );
}

class _ConfirmationClearCacheSheetContent extends StatelessWidget {
  const new({required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressCancel() {
      context.navigator.pop();
    }

    void handleOnPressConfirm() {
      context.navigator.pop();
      onConfirm();
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
                'Clear Cache',
                style: theme.typography.display.sm.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w600,
                ),
              ),
              Text(
                'Are you sure you want to clear temporary cache files? '
                'This will free up memory and storage space.',
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
                    variant: .destructive,
                    size: .sm,
                    onPress: handleOnPressConfirm,
                    child: const Text('Clear'),
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
