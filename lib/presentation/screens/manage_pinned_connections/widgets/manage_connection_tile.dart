import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';

class ManageConnectionTile extends StatelessWidget with FTileMixin {
  const new({
    required this.connection,
    this.onPressPin,
    this.onPressUnpin,
    this.onPressEdit,
    super.key,
  });

  final ConnectionViewModel connection;
  final VoidCallback? onPressPin;
  final VoidCallback? onPressUnpin;
  final VoidCallback? onPressEdit;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressUnpin() {
      onPressUnpin?.call();
    }

    void handleOnPressPin() {
      onPressPin?.call();
    }

    void handleOnPressEdit() {
      onPressEdit?.call();
    }

    return FTile(
      prefix: ConnectionProtocolGlyph(
        connectionProtocol: connection.protocol,
        status: connection.status,
      ),
      title: Text(
        connection.displayName,
        maxLines: 1,
        overflow: .ellipsis,
        style: theme.typography.body.xs.copyWith(
          fontWeight: .w700,
          color: theme.colors.foreground,
        ),
      ),
      subtitle: Text(
        connection.remoteAddress,
        maxLines: 1,
        overflow: .ellipsis,
        style: theme.typography.body.xs2.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
      suffix: Row(
        mainAxisSize: .min,
        spacing: Spacing.sm,
        children: [
          if (connection.isPinned)
            FButton.icon(
              size: .sm,
              variant: .secondary,
              semanticsLabel: 'Unpin ${connection.displayName}',
              onPress: handleOnPressUnpin,
              style: .delta(
                decoration: .delta([
                  .all(const .shapeDelta(shape: CircleBorder())),
                ]),
              ),
              child: const Icon(FLucideIcons.pinOff, size: 16),
            )
          else
            FButton.icon(
              size: .sm,
              semanticsLabel: 'Pin ${connection.displayName}',
              onPress: handleOnPressPin,
              style: .delta(
                decoration: .delta([
                  .all(
                    .shapeDelta(
                      shape: const CircleBorder(),
                      color: theme.colors.muted,
                    ),
                  ),
                ]),
              ),
              child: Icon(
                FLucideIcons.pin,
                size: 16,
                color: theme.colors.mutedForeground,
              ),
            ),
          FButton.icon(
            size: .sm,
            semanticsLabel: 'Edit ${connection.displayName}',
            onPress: handleOnPressEdit,
            style: .delta(
              decoration: .delta([
                .all(
                  .shapeDelta(
                    shape: const CircleBorder(),
                    color: theme.colors.muted,
                  ),
                ),
              ]),
            ),
            child: Icon(
              FLucideIcons.pencil,
              size: 16,
              color: theme.colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
