import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ConnectionsHomeHeader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FHeader(
      title: Row(
        spacing: Spacing.lg,
        children: [
          const _ConnectionsHomeHeaderLogo(),
          Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: Spacing.dot,
            children: [
              Text(
                'ShareHop',
                style: theme.typography.display.md.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w700,
                  height: 1.2,
                ),
              ),
              Text(
                'Transfer files seamlessly',
                style: theme.typography.display.xs2.copyWith(
                  color: theme.colors.mutedForeground,
                  fontWeight: .w500,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConnectionsHomeHeaderLogo extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: theme.colors.foreground,
        borderRadius: theme.style.borderRadius.md,
      ),
      child: Center(
        child: Icon(
          FLucideIcons.arrowLeftRight,
          size: 18,
          color: theme.colors.background,
        ),
      ),
    );
  }
}
