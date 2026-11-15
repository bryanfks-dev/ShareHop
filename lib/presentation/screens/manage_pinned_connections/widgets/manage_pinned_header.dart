import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/add_connection/screen.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ManagePinnedHeader extends StatelessWidget {
  const new({
    required this.onPressDone,
    this.onPressAddConnection,
    super.key,
  });

  final VoidCallback onPressDone;
  final VoidCallback? onPressAddConnection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressDone() {
      onPressDone();
    }

    void handleOnPressAddConnection() {
      if (onPressAddConnection != null) {
        onPressAddConnection!();
      } else {
        context.navigator.push(
          MaterialPageRoute<void>(
            builder: (context) => const AddConnectionScreen(),
          ),
        );
      }
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
      suffixes: [
        FButton.icon(
          size: .sm,
          semanticsLabel: 'Add connection',
          onPress: handleOnPressAddConnection,
          style: .delta(
            decoration: .delta([
              .all(const .shapeDelta(shape: CircleBorder())),
            ]),
          ),
          child: const Icon(FLucideIcons.plus),
        ),
      ],
    );
  }
}
