import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class RetainedFilesBanner extends StatelessWidget {
  const new({required this.fileCount, super.key});

  final int fileCount;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      width: double.infinity,
      padding: const .symmetric(horizontal: Spacing.md, vertical: Spacing.sm),
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.4),
        borderRadius: theme.style.borderRadius.md,
      ),
      child: Row(
        spacing: Spacing.sm,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: theme.colors.primary,
              shape: .circle,
            ),
          ),
          Expanded(
            child: Text(
              'These $fileCount file(s) will be retained while '
              'you set up the new connection.',
              style: theme.typography.body.xs2.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
