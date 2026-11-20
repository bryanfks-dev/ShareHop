import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ShareHeader extends StatelessWidget {
  const new({required this.fileCount, required this.totalSize, super.key});

  final int fileCount;
  final String totalSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: Spacing.xs3,
      children: [
        Text(
          'Transfer with ShareHop',
          style: theme.typography.display.sm.copyWith(
            color: theme.colors.foreground,
            fontWeight: .w700,
          ),
        ),
        Text(
          '$fileCount file(s) selected ($totalSize)',
          style: theme.typography.body.xs2.copyWith(
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
