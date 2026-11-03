import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/tile.dart';
import 'package:forui_lucide/forui_lucide.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';

class ConnectionTile extends HookWidget {
  const new({required this.connection, this.onPress, super.key});

  final ConnectionModel connection;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FTile(
      onPress: onPress,
      prefix: ConnectionProtocolGlyph(
        connectionProtocol: connection.protocol,
        size: 48,
      ),
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            connection.displayName,
            style: theme.typography.display.xs.copyWith(
              color: theme.colors.foreground,
              fontWeight: .w700,
            ),
          ),
          const _ConnectionStatusIndicator(status: ConnectionStatus.online),
        ],
      ),
      subtitle: Column(
        spacing: Spacing.xs2,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text(
            connection.remoteAddress,
            style: theme.typography.body.xs2.copyWith(
              color: theme.colors.foreground,
            ),
          ),
        ],
      ),
      suffix: Icon(
        FLucideIcons.chevronRight,
        color: theme.colors.mutedForeground,
      ),
    );
  }
}

class _ConnectionStatusIndicator extends StatelessWidget {
  const new({required this.status});

  final ConnectionStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    Color color;
    switch (status) {
      case .online:
        color = theme.colors.app.success;
      case .offline:
        color = theme.colors.mutedForeground;
    }

    return Row(
      spacing: Spacing.xs,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: .circle),
        ),
        Text(
          status.label,
          style: theme.typography.body.xs2.copyWith(
            color: color,
            fontWeight: .w600,
          ),
        ),
      ],
    );
  }
}
