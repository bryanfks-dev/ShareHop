import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class DestinationConnectionAddButton extends StatelessWidget {
  const new({this.onAddConnection, super.key});

  final VoidCallback? onAddConnection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressAddConnection() {
      onAddConnection?.call();
    }

    return GestureDetector(
      onTap: handleOnPressAddConnection,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const .only(top: Spacing.xs),
        padding: const .symmetric(vertical: Spacing.md, horizontal: Spacing.md),
        decoration: BoxDecoration(
          color: theme.colors.muted.withValues(alpha: 0.4),
          borderRadius: theme.style.borderRadius.md,
          border: .all(color: theme.colors.border),
        ),
        child: Row(
          mainAxisAlignment: .center,
          spacing: Spacing.sm,
          children: [
            Icon(FLucideIcons.plus, size: 16, color: theme.colors.primary),
            Text(
              'Add New Connection',
              style: theme.typography.body.xs.copyWith(
                color: theme.colors.primary,
                fontWeight: .w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
