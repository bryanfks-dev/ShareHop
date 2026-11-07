import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/theme.dart';
import 'package:sharehop/presentation/controllers/app_info_controller.dart';

class Trademark extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final appInfo = ref.watch(appInfoControllerProvider);

    return appInfo.when(
      data: (v) => Text(
        'ShareHop ${v.display} · Made by bryanfks',
        textAlign: .center,
        style: theme.typography.display.xs2.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
      error: (e, s) => Text(
        'ShareHop 1.0.0 (1) · Made by bryanfks',
        textAlign: .center,
        style: theme.typography.display.xs2.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
      loading: SizedBox.shrink,
    );
  }
}
