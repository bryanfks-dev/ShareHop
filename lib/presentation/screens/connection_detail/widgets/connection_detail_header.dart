import 'package:flutter/material.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/button.dart';
import 'package:forui/widgets/header.dart';
import 'package:forui_lucide/forui_lucide.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ConnectionDetailHeader extends StatelessWidget {
  const new({required this.connection, super.key});

  final ConnectionModel connection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressBack() {
      context.navigator.pop();
    }

    return FHeader(
      title: Row(
        spacing: Spacing.lg,
        children: [
          FButton.icon(
            size: .sm,
            onPress: handleOnPressBack,
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
                connection.displayName,
                style: theme.typography.display.md.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w700,
                ),
              ),
              Text(
                'Connection detail',
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
