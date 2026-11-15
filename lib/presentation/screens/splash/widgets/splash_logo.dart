import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class SplashLogo extends StatelessWidget {
  const new({super.key});

  static const _kLogoContainerSize = 64.0;
  static const _kLogoIconSize = 32.0;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      mainAxisSize: .min,
      spacing: Spacing.md,
      children: [
        Container(
          width: _kLogoContainerSize,
          height: _kLogoContainerSize,
          decoration: BoxDecoration(
            color: theme.colors.foreground,
            borderRadius: theme.style.borderRadius.xl,
          ),
          child: Center(
            child: Icon(
              FLucideIcons.arrowLeftRight,
              size: _kLogoIconSize,
              color: theme.colors.background,
            ),
          ),
        ),
        Column(
          mainAxisSize: .min,
          spacing: Spacing.xs2,
          children: [
            Text(
              'ShareHop',
              style: theme.typography.display.xl3.copyWith(
                color: theme.colors.foreground,
                fontWeight: .w700,
                height: 1.2,
              ),
            ),
            Text(
              'Transfer files seamlessly',
              style: theme.typography.display.xs.copyWith(
                color: theme.colors.mutedForeground,
                fontWeight: .w500,
                height: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
