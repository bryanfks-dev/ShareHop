import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class ManagePinnedEmptyState extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FTileGroup(
      children: [
        FTile(
          title: Center(
            child: Text(
              'No pinned connections.\n'
              'Tap the pin icon below to pin a connection.',
              textAlign: .center,
              style: theme.typography.body.xs2.copyWith(
                color: theme.colors.mutedForeground,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
