import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class TransferSectionHeader extends StatelessWidget {
  const new({
    required this.title,
    this.actionLabel,
    this.onActionPress,
    this.isDestructive = false,
    super.key,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionPress;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressAction() {
      onActionPress?.call();
    }

    final actionColor = isDestructive
        ? theme.colors.destructive
        : theme.colors.primary;

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          title,
          style: theme.typography.display.xs.copyWith(
            color: theme.colors.foreground,
            fontWeight: .w700,
          ),
        ),
        if (actionLabel != null)
          FButton(
            variant: .ghost,
            size: .xs,
            onPress: handleOnPressAction,
            child: Text(
              actionLabel!,
              style: theme.typography.body.xs.copyWith(
                color: actionColor,
                fontWeight: .w600,
              ),
            ),
          ),
      ],
    );
  }
}
