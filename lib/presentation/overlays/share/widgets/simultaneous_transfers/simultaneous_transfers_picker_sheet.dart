import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

const kSimultaneousTransfersLimits = [1, 2, 3, 4, 5];

Future<int?> showSimultaneousTransfersPickerSheet(
  BuildContext context, {
  required int currentLimit,
  ValueChanged<int>? onSelectLimit,
}) => showFSheet<int>(
  context: context,
  side: .btt,
  builder: (sheetContext) => _SimultaneousTransfersPickerSheet(
    currentLimit: currentLimit,
    onSelectLimit: onSelectLimit,
  ),
);

class _SimultaneousTransfersPickerSheet extends HookWidget {
  const new({required this.currentLimit, this.onSelectLimit});

  final int currentLimit;
  final ValueChanged<int>? onSelectLimit;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final innerSelectedLimit = useState<int>(currentLimit);

    void handleOnSelectLimit(int limit) {
      innerSelectedLimit.value = limit;
      onSelectLimit?.call(limit);
      if (context.mounted && context.navigator.canPop()) {
        context.navigator.pop(limit);
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
                  for (final limit in kSimultaneousTransfersLimits)
                    _SimultaneousTransfersPickerSheetItem(
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

class _SimultaneousTransfersPickerSheetItem extends StatelessWidget {
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
