import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class EmptyState extends StatelessWidget {
  const new({
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
    this.iconBackgroundColor,
    this.action,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Widget? action;

  static Widget card({
    required IconData icon,
    required String title,
    required String description,
    Key? key,
    Color? iconColor,
    Color? iconBackgroundColor,
    Widget? action,
  }) {
    return _EmptyStateCard(
      key: key,
      icon: icon,
      title: title,
      description: description,
      iconColor: iconColor,
      iconBackgroundColor: iconBackgroundColor,
      action: action,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.lg,
        horizontal: Spacing.md,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? theme.colors.secondary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 20,
                color: iconColor ?? theme.colors.primary,
              ),
            ),
            const SizedBox(height: Spacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.typography.body.sm.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.foreground,
              ),
            ),
            const SizedBox(height: Spacing.xs2),
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.typography.body.xs2.copyWith(
                color: theme.colors.mutedForeground,
                height: 1.4,
              ),
            ),
            if (action != null) ...[
              const SizedBox(height: Spacing.md),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  const new({
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
    this.iconBackgroundColor,
    this.action,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FTileGroup(
      style: .delta(decoration: .shapeDelta(color: theme.colors.card)),
      children: [
        FTile(
          title: EmptyState(
            icon: icon,
            title: title,
            description: description,
            iconColor: iconColor,
            iconBackgroundColor: iconBackgroundColor,
            action: action,
          ),
        ),
      ],
    );
  }
}
