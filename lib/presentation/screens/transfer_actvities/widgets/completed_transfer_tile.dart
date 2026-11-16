import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class CompletedTransferTile extends StatelessWidget with FTileMixin {
  const new({
    required this.fileName,
    required this.subtitle,
    required this.icon,
    this.statusLabel = 'Completed',
    this.statusIcon,
    this.statusColor,
    this.iconColor,
    this.iconBackgroundColor,
    this.onPress,
    super.key,
  });

  final String fileName;
  final String subtitle;
  final IconData icon;
  final String statusLabel;
  final IconData? statusIcon;
  final Color? statusColor;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final effectiveIconColor = iconColor ?? theme.colors.mutedForeground;
    final effectiveIconBgColor = iconBackgroundColor ?? theme.colors.muted;
    final effectiveStatusIcon = statusIcon ?? FLucideIcons.circleCheck;
    final effectiveStatusColor = statusColor ?? theme.colors.app.success;

    return FTile(
      onPress: onPress,
      prefix: Container(
        width: theme.style.sizes.field.md,
        height: theme.style.sizes.field.md,
        decoration: BoxDecoration(
          color: effectiveIconBgColor,
          borderRadius: theme.style.borderRadius.lg,
        ),
        child: Icon(
          icon,
          color: effectiveIconColor,
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
            effectiveStatusIcon,
            size: 14,
            color: effectiveStatusColor,
          ),
          Text(
            statusLabel,
            style: theme.typography.body.xs2.copyWith(
              color: effectiveStatusColor,
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    );
  }
}
