import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class QueuedTransferTile extends StatelessWidget with FTileMixin {
  const new({
    required this.fileName,
    required this.subtitle,
    this.icon = FLucideIcons.fileArchive,
    this.statusLabel = 'Waiting',
    this.onPress,
    super.key,
  });

  final String fileName;
  final String subtitle;
  final IconData icon;
  final String statusLabel;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FTile(
      onPress: onPress,
      prefix: Container(
        width: theme.style.sizes.field.md,
        height: theme.style.sizes.field.md,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: theme.style.borderRadius.lg,
        ),
        child: Icon(
          icon,
          color: theme.colors.mutedForeground,
          size: theme.style.iconStyle.size,
        ),
      ),
      title: Text(
        fileName,
        maxLines: 1,
        overflow: .ellipsis,
        style: theme.typography.body.sm.copyWith(
          color: theme.colors.foreground,
          fontWeight: .w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: .ellipsis,
        style: theme.typography.body.xs2.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
      suffix: Row(
        mainAxisSize: .min,
        spacing: Spacing.xs,
        children: [
          Icon(
            FLucideIcons.clock,
            size: 14,
            color: theme.colors.app.accentOrange,
          ),
          Text(
            statusLabel,
            style: theme.typography.body.xs2.copyWith(
              color: theme.colors.app.accentOrange,
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    );
  }
}
