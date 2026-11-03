import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/on_file_conflicts_resolution.dart';
import 'package:sharehop/presentation/controllers/app_config_controller.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showChangeOnFileConflictsResolutionSheet(
  BuildContext context,
) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) => _ChangeOnFileConflictsResolutionSheetContent(),
  );
}

class _ChangeOnFileConflictsResolutionSheetContent extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final appConfig = ref.watch(appConfigControllerProvider);
    final appConfigController = ref.watch(appConfigControllerProvider.notifier);

    final innerSelectedOnFileConflictResolution =
        useState<OnFileConflictsResolution>(
          appConfig.value?.onFileConflictsResolution ?? .askeverytime,
        );

    Future<void> handleOnPressResolution({
      required OnFileConflictsResolution resolution,
    }) async {
      innerSelectedOnFileConflictResolution.value = resolution;
      await appConfigController.setOnFileConflictsResolution(
        resolution: resolution,
      );
      if (context.mounted) {
        context.navigator.pop();
      }
    }

    void handleOnPressAskEveryTime() =>
        handleOnPressResolution(resolution: .askeverytime);
    void handleOnPressOverwrite() =>
        handleOnPressResolution(resolution: .overwrite);
    void handleOnPressRename() => handleOnPressResolution(resolution: .rename);
    void handleOnPressSkip() => handleOnPressResolution(resolution: .skip);

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
                'Select file conflicts resolution',
                style: theme.typography.display.sm.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w600,
                ),
              ),
              Column(
                mainAxisSize: .min,
                spacing: Spacing.md,
                children: [
                  _ChangeOnFileConflictsResolutionSheetItem(
                    resolution: .askeverytime,
                    value:
                        innerSelectedOnFileConflictResolution.value ==
                        .askeverytime,
                    onPress: handleOnPressAskEveryTime,
                  ),
                  _ChangeOnFileConflictsResolutionSheetItem(
                    resolution: .overwrite,
                    value:
                        innerSelectedOnFileConflictResolution.value ==
                        .overwrite,
                    onPress: handleOnPressOverwrite,
                  ),
                  _ChangeOnFileConflictsResolutionSheetItem(
                    resolution: .rename,
                    value:
                        innerSelectedOnFileConflictResolution.value == .rename,
                    onPress: handleOnPressRename,
                  ),
                  _ChangeOnFileConflictsResolutionSheetItem(
                    resolution: .skip,
                    value: innerSelectedOnFileConflictResolution.value == .skip,
                    onPress: handleOnPressSkip,
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

class _ChangeOnFileConflictsResolutionSheetItem extends StatelessWidget {
  const new({
    required this.resolution,
    required this.onPress,
    this.value = false,
  });

  final OnFileConflictsResolution resolution;
  final bool value;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnChange({required bool value}) {
      onPress();
    }

    return Container(
      padding: .all(theme.style.pagePadding.top),
      decoration: BoxDecoration(
        border: .all(color: value ? theme.colors.primary : theme.colors.border),
        borderRadius: theme.style.borderRadius.md,
      ),
      child: FRadio(
        label: Text(
          resolution.label,
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
