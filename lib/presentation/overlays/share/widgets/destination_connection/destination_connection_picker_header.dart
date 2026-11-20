import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class DestinationConnectionPickerHeader extends StatelessWidget {
  const new({this.onClose, super.key});

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: Spacing.xs3,
      children: [
        Text(
          'Select Destination',
          style: theme.typography.display.sm.copyWith(
            color: theme.colors.foreground,
            fontWeight: .w700,
          ),
        ),
        Text(
          'Choose a connection to transfer files',
          style: theme.typography.body.xs2.copyWith(
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
