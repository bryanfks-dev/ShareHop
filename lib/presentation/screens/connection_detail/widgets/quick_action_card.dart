import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';

enum QuickActionCardVariant { primary, subtle }

class QuickActionCard extends StatelessWidget {
  const new({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.variant = .subtle,
    this.onPress,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final QuickActionCardVariant variant;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final isPrimary = variant == QuickActionCardVariant.primary;

    final iconBackgroundColor = isPrimary
        ? theme.colors.primaryForeground.withValues(alpha: 0.18)
        : theme.colors.muted;

    final iconColor = isPrimary
        ? theme.colors.primaryForeground
        : theme.colors.primary;

    final titleColor = theme.colors.app.white;

    final subtitleColor = theme.colors.app.white;

    return FTappable(
      onPress: onPress,
      child: FCard(
        style: .delta(
          decoration: .shapeDelta(
            color: isPrimary ? theme.colors.primary : theme.colors.card,
            shape: RoundedSuperellipseBorder(
              borderRadius: theme.style.borderRadius.xl,
              side: isPrimary
                  ? .none
                  : BorderSide(
                      color: theme.colors.border,
                      width: theme.style.borderWidth,
                    ),
            ),
          ),
        ),
        clipBehavior: .antiAlias,
        builder: (cardContext, style, _) {
          return Padding(
            padding: style.padding,
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: Spacing.md,
              children: [
                Container(
                  width: theme.style.sizes.field.md,
                  height: theme.style.sizes.field.md,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius: theme.style.borderRadius.lg,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: theme.style.iconStyle.size,
                  ),
                ),
                Column(
                  spacing: Spacing.xs2,
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: theme.typography.display.xs.copyWith(
                        color: titleColor,
                        fontWeight: .w700,
                      ),
                    ),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: theme.typography.body.xs2.copyWith(
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
