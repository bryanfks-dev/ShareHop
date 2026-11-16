import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/presentation/controllers/settings_controller.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showChangeSimultaneousTransfersLimitSheet(
  BuildContext context,
) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) => _ChangeSimultaneousTransfersLimitSheetContent(),
  );
}

class _ChangeSimultaneousTransfersLimitSheetContent extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final appConfig = ref.watch(settingsControllerProvider);
    final appConfigController = ref.watch(settingsControllerProvider.notifier);

    final innerSelectedLimit = useState<int>(
      appConfig.value?.simultaneousTransfersLimit ?? 3,
    );

    Future<void> handleOnPressLimit({required int limit}) async {
      innerSelectedLimit.value = limit;
      await appConfigController.setSimultaneousTransfersLimit(limit: limit);
      if (context.mounted) {
        context.navigator.pop();
      }
    }

    void handleOnSelectLimit(int limit) {
      unawaited(handleOnPressLimit(limit: limit));
    }

    const kLimits = [1, 2, 3, 4, 5];

    return Container(
      width: double.maxFinite,
      padding: .symmetric(
        vertical: 2 * theme.style.pagePadding.top,
        horizontal: theme.style.pagePadding.left,
      ),
      decoration: BoxDecoration(
        color: theme.colors.card,
        border: .all(color: theme.colors.border),
        borderRadius: theme.style.borderRadius.xl,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: Spacing.lg,
            children: [
              Text(
                'Select simultaneous transfers limit',
                style: theme.typography.display.sm.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w600,
                ),
              ),
              Column(
                mainAxisSize: .min,
                spacing: Spacing.md,
                children: [
                  for (final limit in kLimits)
                    _ChangeSimultaneousTransfersLimitSheetItem(
                      limit: limit,
                      value: innerSelectedLimit.value == limit,
                      onSelect: handleOnSelectLimit,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChangeSimultaneousTransfersLimitSheetItem extends StatelessWidget {
  const new({required this.limit, required this.onSelect, this.value = false});

  final int limit;
  final bool value;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnChange({required bool value}) {
      onSelect(limit);
    }

    return Container(
      padding: .all(theme.style.pagePadding.top),
      decoration: BoxDecoration(
        border: .all(color: value ? theme.colors.primary : theme.colors.border),
        borderRadius: theme.style.borderRadius.md,
      ),
      child: FRadio(
        label: Text(
          '$limit transfer(s)',
          style: theme.typography.body.xs.copyWith(
            color: theme.colors.foreground,
          ),
        ),
        value: value,
        onChange: (val) => handleOnChange(value: val),
      ),
    );
  }
}
