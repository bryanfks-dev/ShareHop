import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/utils/date_formatter.dart';
import 'package:sharehop/presentation/utils/file_icon_resolver.dart';
import 'package:sharehop/presentation/utils/file_size_formatter.dart';

class ActiveTransferCard extends StatelessWidget {
  const new({
    this.transfer,
    this.fileName,
    this.path,
    this.progress = 0.72,
    this.progressStats,
    this.timeRemaining,
    this.securityLabel,
    this.batchIndexText,
    this.icon,
    this.onPausePress,
    this.onCancelPress,
    super.key,
  });

  final FileTransferHistoryModel? transfer;
  final String? fileName;
  final String? path;
  final double progress;
  final String? progressStats;
  final String? timeRemaining;
  final String? securityLabel;
  final String? batchIndexText;
  final IconData? icon;
  final VoidCallback? onPausePress;
  final VoidCallback? onCancelPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final effectiveFileName =
        fileName ?? transfer?.fileName ?? 'product-demo-final.mp4';
    final effectivePath =
        path ??
        (transfer != null
            ? '${transfer!.sourceName} → ${transfer!.destinationName}'
            : 'On My iPhone → Production / releases');
    final effectiveProgressStats =
        progressStats ??
        (transfer != null
            ? formatFileSize(bytes: transfer!.fileSize)
            : '72% · 132.9 of 184.7 MB · 132.9 of 184.7 MB');
    final effectiveTimeRemaining =
        timeRemaining ??
        (transfer != null
            ? formatTimeAgo(date: transfer!.updatedAt)
            : '6 sec left');
    final effectiveSecurityLabel =
        securityLabel ??
        (transfer != null ? 'Encrypted Transfer' : 'Encrypted SFTP');
    final effectiveBatchIndexText =
        batchIndexText ?? (transfer != null ? 'Active' : '1 of 3 files');
    final effectiveIcon =
        icon ??
        (transfer != null
            ? transfer!.fileName.fileIcon
            : FLucideIcons.fileVideo);

    void handleOnPressPause() {
      (onPausePress ?? onCancelPress)?.call();
    }

    return FCard(
      builder: (cardContext, style, _) {
        return Padding(
          padding: style.padding,
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: Spacing.md,
            children: [
              Row(
                spacing: Spacing.sm,
                children: [
                  Container(
                    width: theme.style.sizes.field.md,
                    height: theme.style.sizes.field.md,
                    decoration: BoxDecoration(
                      color: theme.colors.destructive.withValues(alpha: 0.1),
                      borderRadius: theme.style.borderRadius.lg,
                    ),
                    child: Icon(
                      effectiveIcon,
                      color: theme.colors.destructive,
                      size: theme.style.iconStyle.size,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      spacing: Spacing.xs3,
                      children: [
                        Text(
                          effectiveFileName,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: theme.typography.body.sm.copyWith(
                            color: theme.colors.foreground,
                            fontWeight: .w700,
                          ),
                        ),
                        Text(
                          effectivePath,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: theme.typography.body.xs2.copyWith(
                            color: theme.colors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FButton.icon(
                    size: .sm,
                    onPress: handleOnPressPause,
                    child: const Icon(FLucideIcons.pause),
                  ),
                ],
              ),
              Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                spacing: Spacing.sm,
                children: [
                  FDeterminateProgress(value: progress),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    spacing: Spacing.sm,
                    children: [
                      Expanded(
                        child: Text(
                          effectiveProgressStats,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: theme.typography.body.xs2.copyWith(
                            color: theme.colors.primary,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                      Text(
                        effectiveTimeRemaining,
                        style: theme.typography.body.xs2.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    mainAxisSize: .min,
                    spacing: Spacing.xs,
                    children: [
                      Icon(
                        FLucideIcons.lock,
                        size: 14,
                        color: theme.colors.app.accentTeal,
                      ),
                      Text(
                        effectiveSecurityLabel,
                        style: theme.typography.body.xs2.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    effectiveBatchIndexText,
                    style: theme.typography.body.xs2.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
