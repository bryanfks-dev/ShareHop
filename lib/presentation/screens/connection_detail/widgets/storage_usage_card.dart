import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/data/dto/storage_status_dto.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class StorageUsageCard extends StatelessWidget {
  const new({
    this.storageStatus,
    this.isLoading = false,
    this.onRefresh,
    super.key,
  });

  final StorageStatusDto? storageStatus;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final usedString = storageStatus != null
        ? '${StorageStatusDto.formatBytes(
            bytes: storageStatus!.usedBytes,
          )} used'
        : '436 GB used';

    final availableString = storageStatus != null
        ? StorageStatusDto.formatBytes(bytes: storageStatus!.freeBytes)
        : '64 GB';

    final progressValue = storageStatus?.usedPercentage ?? (436 / 500);

    final summaryString = storageStatus != null
        ? '${(storageStatus!.usedPercentage * 100).toInt()}% of '
            '${StorageStatusDto.formatBytes(
            bytes: storageStatus!.totalBytes,
          )} used · updated just now'
        : '87% of 500 GB used · updated just now';

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
                        usedString,
                        style: theme.typography.display.md.copyWith(
                          color: theme.colors.foreground,
                          fontWeight: .w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: .min,
                    spacing: Spacing.xs,
                    children: [
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
                            availableString,
                            style: theme.typography.display.xs.copyWith(
                              color: theme.colors.primary,
                            ),
                          ),
                        ],
                      ),
                      if (onRefresh != null)
                        FButton.icon(
                          size: .xs,
                          variant: .ghost,
                          semanticsLabel: 'Refresh storage',
                          onPress: onRefresh,
                          child: const Icon(FLucideIcons.refreshCw, size: 14),
                        ),
                    ],
                  ),
                ],
              ),
              if (isLoading)
                const FProgress()
              else
                FDeterminateProgress(value: progressValue),
              Text(
                summaryString,
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
