import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';

class DestinationConnectionTile extends StatelessWidget {
  const new({
    required this.connection,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });

  final ConnectionViewModel connection;
  final bool isSelected;
  final ValueChanged<ConnectionViewModel> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPress() {
      onSelect(connection);
    }

    return GestureDetector(
      key: ValueKey(connection.id),
      onTap: handleOnPress,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const .symmetric(vertical: Spacing.xs2),
        padding: const .all(Spacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colors.primary.withValues(alpha: 0.05)
              : theme.colors.card,
          borderRadius: theme.style.borderRadius.md,
          border: .all(
            color: isSelected ? theme.colors.primary : theme.colors.border,
            width: theme.style.borderWidth,
          ),
        ),
        child: Row(
          spacing: Spacing.md,
          children: [
            ConnectionProtocolGlyph(
              connectionProtocol: connection.protocol,
              status: connection.status,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                spacing: Spacing.xs3,
                children: [
                  Row(
                    spacing: Spacing.xs,
                    children: [
                      Flexible(
                        child: Text(
                          connection.displayName,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: theme.typography.body.xs.copyWith(
                            color: theme.colors.foreground,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                      if (connection.isPinned)
                        Icon(
                          FLucideIcons.pin,
                          size: 12,
                          color: theme.colors.primary,
                        ),
                    ],
                  ),
                  Text(
                    connection.remoteAddress,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: theme.typography.body.xs2.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(FLucideIcons.check, size: 18, color: theme.colors.primary),
          ],
        ),
      ),
    );
  }
}
