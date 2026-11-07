import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/tile.dart';
import 'package:forui_lucide/forui_lucide.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';

class ConnectionTile extends HookWidget {
  const new({required this.connection, this.status, this.onPress, super.key});

  final ConnectionViewModel connection;
  final ConnectionStatus? status;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FTile(
      onPress: onPress,
      prefix: ConnectionProtocolGlyph(
        connectionProtocol: connection.protocol,
        status: status ?? connection.status,
        size: 48,
      ),
      title: Text(
        connection.displayName,
        maxLines: 1,
        overflow: .ellipsis,
        style: theme.typography.display.xs.copyWith(
          color: theme.colors.foreground,
          fontWeight: .w700,
        ),
      ),
      subtitle: Text(
        connection.remoteAddress,
        maxLines: 1,
        overflow: .ellipsis,
        style: theme.typography.body.xs2.copyWith(
          color: theme.colors.foreground,
        ),
      ),
      suffix: Icon(
        FLucideIcons.chevronRight,
        color: theme.colors.mutedForeground,
      ),
    );
  }
}
