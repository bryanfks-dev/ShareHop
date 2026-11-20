import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/utils/file_icon_resolver.dart';

class SelectedFilesSummaryCard extends StatelessWidget {
  const new({required this.item, this.onOpenFiles, super.key});

  final ShareIntegrationItem item;
  final VoidCallback? onOpenFiles;

  IconData _resolveIcon() {
    if (item.fileCount == 0) {
      return FLucideIcons.fileX;
    }

    if (item.files.isEmpty) {
      if (item.subtitle.toLowerCase().contains('image') ||
          item.title.toLowerCase().contains('image') ||
          item.title.toLowerCase().contains('jpg') ||
          item.title.toLowerCase().contains('png')) {
        return FLucideIcons.image;
      }
      return FLucideIcons.file;
    }

    final first = item.files.first;
    final isImage =
        first.mimeType.startsWith('image/') ||
        first.name.toLowerCase().endsWith('.jpg') ||
        first.name.toLowerCase().endsWith('.jpeg') ||
        first.name.toLowerCase().endsWith('.png') ||
        first.name.toLowerCase().endsWith('.webp') ||
        first.name.toLowerCase().endsWith('.gif') ||
        item.subtitle.toLowerCase().contains('image');

    if (isImage) {
      return FLucideIcons.image;
    }

    return first.name.fileIcon;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final icon = _resolveIcon();

    void handleOnPressOpenFiles() {
      onOpenFiles?.call();
    }

    return GestureDetector(
      onTap: handleOnPressOpenFiles,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const .all(Spacing.md),
        decoration: BoxDecoration(
          color: theme.colors.card,
          borderRadius: theme.style.borderRadius.xl,
          border: .all(color: theme.colors.border),
        ),
        child: Row(
          spacing: Spacing.md,
          children: [
            _FileIconBox(icon: icon, fileCount: item.fileCount),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                spacing: Spacing.xs3,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: theme.typography.body.xs.copyWith(
                      color: item.fileCount == 0
                          ? theme.colors.mutedForeground
                          : theme.colors.foreground,
                      fontWeight: .w600,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: theme.typography.body.xs2.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: .min,
              spacing: Spacing.xs,
              children: [
                Container(
                  padding: const .symmetric(
                    horizontal: Spacing.sm,
                    vertical: Spacing.xs3,
                  ),
                  decoration: BoxDecoration(
                    color: item.fileCount == 0
                        ? theme.colors.muted
                        : theme.colors.secondary,
                    borderRadius: theme.style.borderRadius.md,
                  ),
                  child: Text(
                    '${item.fileCount}',
                    style: theme.typography.body.xs2.copyWith(
                      color: item.fileCount == 0
                          ? theme.colors.mutedForeground
                          : theme.colors.primary,
                      fontWeight: .w700,
                    ),
                  ),
                ),
                Icon(
                  FLucideIcons.chevronRight,
                  size: 16,
                  color: theme.colors.mutedForeground,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FileIconBox extends StatelessWidget {
  const new({required this.icon, required this.fileCount});

  final IconData icon;
  final int fileCount;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    if (fileCount > 1) {
      return SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: theme.colors.muted,
                  borderRadius: theme.style.borderRadius.md,
                  border: .all(color: theme.colors.border),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: theme.colors.secondary,
                  borderRadius: theme.style.borderRadius.md,
                  border: .all(color: theme.colors.border),
                ),
                child: Center(
                  child: Icon(icon, size: 20, color: theme.colors.primary),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final isZero = fileCount == 0;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isZero ? theme.colors.muted : theme.colors.secondary,
        borderRadius: theme.style.borderRadius.md,
        border: .all(color: theme.colors.border),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 20,
          color: isZero ? theme.colors.mutedForeground : theme.colors.primary,
        ),
      ),
    );
  }
}
