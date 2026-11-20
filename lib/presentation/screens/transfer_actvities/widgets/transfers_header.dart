import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class TransfersHeader extends StatelessWidget {
  const new({
    required this.activeTransferCount,
    required this.queueTransferCount,
    this.onMorePress,
    super.key,
  });

  final int activeTransferCount;
  final int queueTransferCount;
  final VoidCallback? onMorePress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressMore() {
      onMorePress?.call();
    }

    return FHeader(
      title: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: Spacing.dot,
        children: [
          Text(
            'Transfers',
            style: theme.typography.display.md.copyWith(
              color: theme.colors.foreground,
              fontWeight: .w700,
            ),
          ),
          Text(
            '$activeTransferCount active · $queueTransferCount queued',
            style: theme.typography.display.xs2.copyWith(
              color: theme.colors.mutedForeground,
              fontWeight: .w400,
            ),
          ),
        ],
      ),
      suffixes: [
        FButton.icon(
          size: .sm,
          variant: .secondary,
          style: .delta(
            decoration: .delta([
              .all(const .shapeDelta(shape: CircleBorder())),
            ]),
          ),
          onPress: handleOnPressMore,
          child: const Icon(FLucideIcons.ellipsis),
        ),
      ],
    );
  }
}
