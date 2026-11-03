import 'package:flutter/material.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class SettingsHeader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FHeader(
      title: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: Spacing.dot,
        children: [
          Text(
            'Settings',
            style: theme.typography.display.md.copyWith(
              color: theme.colors.foreground,
              fontWeight: .w700,
            ),
          ),
          Text(
            'Make ShareHop work your way',
            style: theme.typography.display.xs2.copyWith(
              color: theme.colors.mutedForeground,
              fontWeight: .w400,
            ),
          ),
        ],
      ),
    );
  }
}
