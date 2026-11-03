import 'package:flutter/material.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/card.dart';
import 'package:forui/widgets/progress.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class StorageUsageCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FCard(
      builder: (cardContext, style, _) {
        return Padding(
          padding: style.padding,
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: Spacing.sm,
            children: [
              Row(
                crossAxisAlignment: .start,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      Text(
                        'REMOTE STORAGE',
                        style: theme.typography.display.xs2.copyWith(
                          color: theme.colors.foreground,
                        ),
                      ),
                      Text(
                        '436 GB used',
                        style: theme.typography.display.md.copyWith(
                          color: theme.colors.foreground,
                          fontWeight: .w700,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: .end,
                    children: [
                      Text(
                        'Available',
                        style: theme.typography.display.xs3.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                      Text(
                        '64 GB',
                        style: theme.typography.display.xs.copyWith(
                          color: theme.colors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const FDeterminateProgress(value: 436 / 500),
              Text(
                '87% of 500 GB used · updated just now',
                style: theme.typography.body.xs3.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
