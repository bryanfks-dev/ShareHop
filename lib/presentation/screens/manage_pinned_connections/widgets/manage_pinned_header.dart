import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ManagePinnedHeader extends StatelessWidget {
  const new({required this.onPressDone, super.key});

  final VoidCallback onPressDone;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressDone() {
      onPressDone();
    }

    return FHeader(
      title: Row(
        spacing: Spacing.lg,
        children: [
          FButton.icon(
            size: .sm,
            onPress: handleOnPressDone,
            style: .delta(
              decoration: .delta([
                .all(const .shapeDelta(shape: CircleBorder())),
              ]),
            ),
            child: const Icon(FLucideIcons.chevronLeft),
          ),
          Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: Spacing.dot,
            children: [
              Text(
                'Manage pinned',
                style: theme.typography.display.md.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w700,
                ),
              ),
              Text(
                'Connections shown on Home',
                style: theme.typography.display.xs2.copyWith(
                  color: theme.colors.mutedForeground,
                  fontWeight: .w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
