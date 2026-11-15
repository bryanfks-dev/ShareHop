import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/primitives/trademark.dart';

class SplashLockedFooter extends StatelessWidget {
  const new({
    required this.onPressUnlock,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback onPressUnlock;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    void handleOnPress() {
      onPressUnlock();
    }

    return Column(
      mainAxisSize: .min,
      spacing: Spacing.md,
      children: [
        FButton(
          onPress: isLoading ? null : handleOnPress,
          prefix: isLoading
              ? const FCircularProgress(size: .sm)
              : const Icon(FLucideIcons.lock, size: 16),
          child: const Text('Unlock ShareHop'),
        ),
        const Trademark(),
      ],
    );
  }
}
