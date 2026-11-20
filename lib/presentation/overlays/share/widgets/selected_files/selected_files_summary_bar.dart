import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class SelectedFilesSummaryBar extends StatelessWidget {
  const new({
    required this.activeCount,
    required this.activeFormattedSize,
    required this.excludedCount,
    this.onExcludeAll,
    this.onIncludeAll,
    super.key,
  });

  final int activeCount;
  final String activeFormattedSize;
  final int excludedCount;
  final VoidCallback? onExcludeAll;
  final VoidCallback? onIncludeAll;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressExcludeAll() {
      onExcludeAll?.call();
    }

    void handleOnPressIncludeAll() {
      onIncludeAll?.call();
    }

    return Container(
      width: double.maxFinite,
      padding: const .symmetric(horizontal: Spacing.md, vertical: Spacing.xs),
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.35),
        borderRadius: theme.style.borderRadius.md,
        border: .all(color: theme.colors.border),
      ),
      child: Row(
        spacing: Spacing.xs,
        children: [
          Icon(
            FLucideIcons.files,
            size: 14,
            color: theme.colors.mutedForeground,
          ),
          Expanded(
            child: Text(
              activeCount == 0
                  ? '0 files ready to transfer'
                  : '$activeCount ready ($activeFormattedSize)',
              style: theme.typography.body.xs2.copyWith(
                color: theme.colors.mutedForeground,
                fontWeight: .w500,
              ),
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),
          if (activeCount > 1)
            GestureDetector(
              onTap: handleOnPressExcludeAll,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const .symmetric(
                  horizontal: Spacing.xs,
                  vertical: Spacing.xs3,
                ),
                child: Text(
                  'Exclude all',
                  style: theme.typography.body.xs2.copyWith(
                    color: theme.colors.destructive,
                    fontWeight: .w600,
                  ),
                ),
              ),
            ),
          if (activeCount > 1 && excludedCount > 0)
            Text(
              '·',
              style: theme.typography.body.xs2.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
          if (excludedCount > 0)
            GestureDetector(
              onTap: handleOnPressIncludeAll,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const .symmetric(
                  horizontal: Spacing.xs,
                  vertical: Spacing.xs3,
                ),
                child: Text(
                  'Include all',
                  style: theme.typography.body.xs2.copyWith(
                    color: theme.colors.primary,
                    fontWeight: .w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
