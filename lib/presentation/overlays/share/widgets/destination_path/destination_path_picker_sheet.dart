import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<String?> showDestinationPathPickerSheet(
  BuildContext context, {
  required String initialPath,
}) => showFSheet<String>(
  context: context,
  side: .btt,
  builder: (sheetContext) =>
      _DestinationPathPickerSheet(initialPath: initialPath),
);

Future<String?> showDestinationPathSheet(
  BuildContext context, {
  required String initialPath,
}) => showDestinationPathPickerSheet(context, initialPath: initialPath);

class _DestinationPathPickerSheet extends HookWidget {
  const new({required this.initialPath});

  final String initialPath;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final controller = useTextEditingController(text: initialPath);

    void handleOnPressConfirm() {
      final path = controller.text.trim();
      if (context.mounted && context.navigator.canPop()) {
        context.navigator.pop(path);
      }
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
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: Spacing.md,
          children: [
            Text(
              'Destination Path',
              style: theme.typography.display.sm.copyWith(
                color: theme.colors.foreground,
                fontWeight: .w700,
              ),
            ),
            FTextField(
              control: .managed(controller: controller),
              hint: '/path/to/folder',
            ),
            const SizedBox(height: Spacing.xs2),
            SizedBox(
              width: double.infinity,
              child: FButton(
                size: .lg,
                onPress: handleOnPressConfirm,
                child: const Text('Confirm path'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
