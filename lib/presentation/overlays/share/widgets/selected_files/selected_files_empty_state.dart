import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class SelectedFilesEmptyState extends StatelessWidget {
  const new({this.hasExcludedFiles = false, this.onRestoreAll, super.key});

  final bool hasExcludedFiles;
  final VoidCallback? onRestoreAll;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressRestoreAll() {
      onRestoreAll?.call();
    }

    return Container(
      width: double.infinity,
      padding: const .symmetric(vertical: Spacing.xl, horizontal: Spacing.md),
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.3),
        borderRadius: theme.style.borderRadius.lg,
        border: .all(color: theme.colors.border),
      ),
      child: Center(
        child: Column(
          mainAxisSize: .min,
          spacing: Spacing.xs,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.colors.muted,
                shape: .circle,
              ),
              child: Center(
                child: Icon(
                  FLucideIcons.fileX,
                  size: 22,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
            Text(
              'No files selected',
              style: theme.typography.body.xs.copyWith(
                color: theme.colors.mutedForeground,
                fontWeight: .w600,
              ),
            ),
            Text(
              'All files have been excluded.',
              style: theme.typography.body.xs2.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
            if (hasExcludedFiles) ...[
              const SizedBox(height: Spacing.xs2),
              FButton(
                size: .sm,
                prefix: const Icon(FLucideIcons.rotateCcw, size: 14),
                onPress: handleOnPressRestoreAll,
                child: const Text('Restore all files'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
