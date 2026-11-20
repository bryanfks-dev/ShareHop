import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/utils/file_category_resolver.dart';
import 'package:sharehop/presentation/utils/file_icon_resolver.dart';

class SelectedFileItemCard extends StatelessWidget {
  const new({
    required this.file,
    required this.isExcluded,
    required this.onActionPress,
    super.key,
  });

  final SharedFileInfo file;
  final bool isExcluded;
  final VoidCallback onActionPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final category = resolveFileCategory(
      fileName: file.name,
      mimeType: file.mimeType,
    );
    final accentColor = resolveCategoryColor(category: category, theme: theme);
    final ext = extractFileExtension(fileName: file.name);

    void handleOnPressAction() {
      onActionPress();
    }

    return Container(
      padding: const .all(Spacing.md),
      decoration: BoxDecoration(
        color: isExcluded
            ? theme.colors.muted.withValues(alpha: 0.35)
            : theme.colors.card,
        borderRadius: theme.style.borderRadius.lg,
        border: .all(color: theme.colors.border),
      ),
      child: Row(
        spacing: Spacing.md,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isExcluded
                  ? theme.colors.muted
                  : accentColor.withValues(alpha: 0.12),
              borderRadius: theme.style.borderRadius.md,
              border: .all(
                color: isExcluded
                    ? theme.colors.border
                    : accentColor.withValues(alpha: 0.25),
              ),
            ),
            child: Center(
              child: Icon(
                file.name.fileIcon,
                size: 20,
                color: isExcluded ? theme.colors.mutedForeground : accentColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: Spacing.xs3,
              children: [
                Text(
                  file.name,
                  style: theme.typography.body.xs.copyWith(
                    color: isExcluded
                        ? theme.colors.mutedForeground
                        : theme.colors.foreground,
                    fontWeight: isExcluded ? .w500 : .w600,
                  ),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
                Row(
                  spacing: Spacing.xs,
                  children: [
                    Text(
                      file.formattedSize,
                      style: theme.typography.body.xs2.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                    if (ext.isNotEmpty) ...[
                      Text(
                        '·',
                        style: theme.typography.body.xs2.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                      Container(
                        padding: const .symmetric(
                          horizontal: Spacing.xs,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: isExcluded
                              ? theme.colors.muted
                              : accentColor.withValues(alpha: 0.1),
                          borderRadius: theme.style.borderRadius.xs,
                        ),
                        child: Text(
                          ext.toUpperCase(),
                          style: theme.typography.body.xs3.copyWith(
                            color: isExcluded
                                ? theme.colors.mutedForeground
                                : accentColor,
                            fontWeight: .w700,
                          ),
                        ),
                      ),
                    ],
                    if (isExcluded)
                      Container(
                        padding: const .symmetric(
                          horizontal: Spacing.xs,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colors.destructive.withValues(
                            alpha: 0.08,
                          ),
                          borderRadius: theme.style.borderRadius.xs,
                        ),
                        child: Text(
                          'Excluded',
                          style: theme.typography.body.xs3.copyWith(
                            color: theme.colors.destructive,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          FButton.icon(
            size: .sm,
            variant: .ghost,
            semanticsLabel: isExcluded
                ? 'Include ${file.name}'
                : 'Exclude ${file.name}',
            onPress: handleOnPressAction,
            child: Icon(
              isExcluded ? FLucideIcons.plus : FLucideIcons.x,
              size: 16,
              color: isExcluded
                  ? theme.colors.primary
                  : theme.colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
