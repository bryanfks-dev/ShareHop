import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ConnectionListEmptyState extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Center(
      child: Column(
        mainAxisAlignment: .center,
        spacing: Spacing.sm,
        children: [
          Icon(
            FLucideIcons.link2Off,
            size: 48,
            color: theme.colors.mutedForeground,
          ),
          Text(
            'No pinned connections',
            style: theme.typography.display.xs.copyWith(
              color: theme.colors.foreground,
              fontWeight: .w600,
            ),
          ),
          Text(
            'You can pin your favorite connections here.',
            style: theme.typography.body.xs.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
