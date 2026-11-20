import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class AddConnectionCard extends StatelessWidget {
  const new({this.onOpen, this.onPressOpen, super.key});

  final VoidCallback? onOpen;
  final VoidCallback? onPressOpen;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressOpen() {
      (onPressOpen ?? onOpen)?.call();
    }

    return Container(
      width: double.infinity,
      padding: const .all(Spacing.md),
      decoration: BoxDecoration(
        color: theme.colors.card,
        borderRadius: theme.style.borderRadius.lg,
        border: .all(
          color: theme.colors.border,
          width: theme.style.borderWidth,
        ),
      ),
      child: Row(
        spacing: Spacing.md,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colors.secondary,
              borderRadius: theme.style.borderRadius.md,
            ),
            child: Center(
              child: Icon(
                FLucideIcons.plus,
                size: 20,
                color: theme.colors.primary,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: Spacing.xs3,
              children: [
                Text(
                  'Add new connection',
                  style: theme.typography.body.xs.copyWith(
                    color: theme.colors.foreground,
                    fontWeight: .w600,
                  ),
                ),
                Text(
                  'Open ShareHop to configure it',
                  style: theme.typography.body.xs2.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          FButton(
            size: .xs,
            variant: .ghost,
            onPress: handleOnPressOpen,
            child: Text(
              'Open',
              style: theme.typography.body.xs.copyWith(
                color: theme.colors.primary,
                fontWeight: .w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
