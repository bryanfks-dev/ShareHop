import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ManageOtherConnectionsFilterChip extends StatelessWidget {
  const new({
    required this.label,
    required this.isSelected,
    required this.onPress,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPress() {
      onPress();
    }

    return FTappable(
      onPress: handleOnPress,
      semanticsLabel: 'Filter by $label',
      excludeSemantics: true,
      child: FBadge(
        variant: isSelected ? .primary : .outline,
        child: Text(
          label,
          style: theme.typography.body.xs.copyWith(
            color: isSelected
                ? theme.colors.primaryForeground
                : theme.colors.foreground,
            fontWeight: isSelected ? .w600 : .w500,
          ),
        ),
      ),
    );
  }
}
