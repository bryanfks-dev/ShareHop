import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class ActiveTransferCard extends StatelessWidget {
  const new({
    this.fileName = 'product-demo-final.mp4',
    this.path = 'On My iPhone → Production / releases',
    this.progress = 0.72,
    this.progressStats = '72% · 132.9 of 184.7 MB · 132.9 of 184.7 MB',
    this.timeRemaining = '6 sec left',
    this.securityLabel = 'Encrypted SFTP',
    this.batchIndexText = '1 of 3 files',
    this.onPausePress,
    super.key,
  });

  final String fileName;
  final String path;
  final double progress;
  final String progressStats;
  final String timeRemaining;
  final String securityLabel;
  final String batchIndexText;
  final VoidCallback? onPausePress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressPause() {
      onPausePress?.call();
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
                      FLucideIcons.fileVideo,
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
                          fileName,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: theme.typography.body.sm.copyWith(
                            color: theme.colors.foreground,
                            fontWeight: .w700,
                          ),
                        ),
                        Text(
                          path,
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
                          progressStats,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: theme.typography.body.xs2.copyWith(
                            color: theme.colors.primary,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                      Text(
                        timeRemaining,
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
                        securityLabel,
                        style: theme.typography.body.xs2.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    batchIndexText,
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
