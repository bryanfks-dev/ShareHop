import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showChangeDownloadDestinationSheet(
  BuildContext context, {
  required String currentPath,
  required ValueChanged<String> onSaved,
}) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) => _ChangeDownloadDestinationSheetContent(
      currentPath: currentPath,
      onSaved: onSaved,
    ),
  );
}

class _ChangeDownloadDestinationSheetContent extends HookWidget {
  const new({required this.currentPath, required this.onSaved});

  final String currentPath;
  final ValueChanged<String> onSaved;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final controller = useTextEditingController(text: currentPath);

    void handleOnPressCancel() {
      context.navigator.pop();
    }

    void handleOnPressSave() {
      final trimmed = controller.text.trim();
      if (trimmed.isNotEmpty) {
        onSaved(trimmed);
      }
      context.navigator.pop();
    }

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
                'Download Destination',
                style: theme.typography.display.sm.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w600,
                ),
              ),
              Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                spacing: Spacing.sm,
                children: [
                  Text(
                    'Enter local directory path to save downloaded files:',
                    style: theme.typography.body.xs.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                  FTextField(
                    control: .managed(controller: controller),
                    hint: '/path/to/download',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: .end,
                spacing: Spacing.md,
                children: [
                  FButton(
                    variant: .outline,
                    size: .sm,
                    onPress: handleOnPressCancel,
                    child: const Text('Cancel'),
                  ),
                  FButton(
                    size: .sm,
                    onPress: handleOnPressSave,
                    child: const Text('Save'),
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
