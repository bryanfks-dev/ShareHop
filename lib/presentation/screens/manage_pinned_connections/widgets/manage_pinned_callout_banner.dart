import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ManagePinnedCalloutBanner extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FAlert(
      icon: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: theme.colors.card,
          shape: .circle,
        ),
        child: Center(
          child: Icon(
            FLucideIcons.pin,
            size: 18,
            color: theme.colors.primary,
          ),
        ),
      ),
      style: .delta(
        decoration: .shapeDelta(
          color: theme.colors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(Spacing.lg),
            side: BorderSide(
              color: theme.colors.primary.withValues(alpha: 0.15),
            ),
          ),
        ),
        padding: const .value(.all(Spacing.lg)),
      ),
      title: Text(
        'Pinned items appear on Home for fast access. '
        'Drag to reorder, unpin, or edit a connection.',
        style: theme.typography.body.xs2.copyWith(
          color: theme.colors.foreground,
          fontWeight: .w400,
          height: 1.4,
        ),
      ),
    );
  }
}
