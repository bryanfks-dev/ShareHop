import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/simultaneous_transfers/simultaneous_transfers_picker_sheet.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class SimultaneousTransfersCard extends HookWidget {
  const new({
    this.simultaneousTransfers = 3,
    this.onSimultaneousTransfersChanged,
    this.onPress,
    super.key,
  });

  final int simultaneousTransfers;
  final ValueChanged<int>? onSimultaneousTransfersChanged;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final currentLimit = useState<int>(simultaneousTransfers);

    useEffect(() {
      currentLimit.value = simultaneousTransfers;
      return null;
    }, [simultaneousTransfers]);

    Future<void> handleOnPress() async {
      onPress?.call();
      final newLimit = await showSimultaneousTransfersPickerSheet(
        context,
        currentLimit: currentLimit.value,
      );
      if (context.mounted && newLimit != null) {
        currentLimit.value = newLimit;
        onSimultaneousTransfersChanged?.call(newLimit);
      }
    }

    final count = currentLimit.value;
    final transferLabel = '$count ${count == 1 ? 'transfer' : 'transfers'}';

    return GestureDetector(
      onTap: handleOnPress,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const .symmetric(horizontal: Spacing.md, vertical: Spacing.md),
        decoration: BoxDecoration(
          color: theme.colors.card,
          borderRadius: theme.style.borderRadius.xl,
          border: .all(color: theme.colors.border),
        ),
        child: Row(
          spacing: Spacing.sm,
          children: [
            Icon(FLucideIcons.layers, size: 18, color: theme.colors.primary),
            Expanded(
              child: Text(
                'Simultaneous transfers',
                style: theme.typography.body.xs.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w500,
                ),
              ),
            ),
            Row(
              mainAxisSize: .min,
              spacing: Spacing.xs,
              children: [
                Text(
                  transferLabel,
                  style: theme.typography.body.xs2.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Icon(
                  FLucideIcons.chevronRight,
                  size: 16,
                  color: theme.colors.mutedForeground,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
