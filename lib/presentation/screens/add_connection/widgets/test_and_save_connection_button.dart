import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class TestAndSaveConnectionButton extends StatelessWidget {
  const new({this.onPress, this.isLoading = false, super.key});

  final VoidCallback? onPress;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPress() {
      onPress?.call();
    }

    return Column(
      spacing: Spacing.md,
      mainAxisSize: .min,
      children: [
        FButton(
          size: .lg,
          onPress: isLoading ? null : handleOnPress,
          prefix: isLoading
              ? const FCircularProgress(size: .sm)
              : const Icon(FLucideIcons.plugZap, size: 18),
          child: const Text('Test & save connection'),
        ),
        Text(
          'Credentials stay encrypted on this device',
          style: theme.typography.body.xs3.copyWith(
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
