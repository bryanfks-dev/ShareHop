import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/extensions/enums/connection_protocol_extension.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/constants/connection_protocol_glyph.dart';

class ConnectionProtocolGlyph extends StatelessWidget {
  const new({
    required this.connectionProtocol,
    this.status,
    this.size = kConnectionProtocolGlyphDefaultSize,
    super.key,
  });

  final ConnectionProtocol connectionProtocol;
  final ConnectionStatus? status;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    Color backgroundColor;
    switch (connectionProtocol) {
      case .ftp:
        backgroundColor = theme.colors.app.accentOrange;
      case .sftp:
        backgroundColor = theme.colors.app.accentBlue;
      case .webdav:
        backgroundColor = theme.colors.app.accentTeal;
      case .smb:
        backgroundColor = theme.colors.app.accentGreen;
      case .ftps:
        backgroundColor = theme.colors.app.accentPurple;
      case .nfs:
        backgroundColor = theme.colors.app.accentRed;
    }

    Color foregroundColor;
    switch (connectionProtocol) {
      case .ftp:
        foregroundColor = theme.colors.app.accentOrangeForeground;
      case .sftp:
        foregroundColor = theme.colors.app.accentBlueForeground;
      case .webdav:
        foregroundColor = theme.colors.app.accentTealForeground;
      case .smb:
        foregroundColor = theme.colors.app.accentGreenForeground;
      case .ftps:
        foregroundColor = theme.colors.app.accentPurpleForeground;
      case .nfs:
        foregroundColor = theme.colors.app.accentRedForeground;
    }

    final glyph = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: .circular(size * 0.365),
      ),
      child: Center(
        child: Text(
          connectionProtocol.shortName,
          style: theme.typography.display.xs.copyWith(
            color: foregroundColor,
            fontSize: size * 0.275,
            fontWeight: .w700,
          ),
        ),
      ),
    );

    if (status == null) {
      return glyph;
    }

    Color statusColor;
    switch (status!) {
      case .online:
        statusColor = theme.colors.app.success;
      case .ready:
        statusColor = theme.colors.app.accentBlue;
      case .idle:
        statusColor = theme.colors.app.accentTeal;
      case .offline:
        statusColor = theme.colors.mutedForeground;
    }

    final dotSize = (size * 0.36).clamp(13.0, 18.0);
    final isOffline = status == .offline;

    final dot = isOffline
        ? Container(
            width: dotSize,
            height: dotSize,
            padding: const .all(1.5),
            decoration: BoxDecoration(color: theme.colors.card, shape: .circle),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colors.card,
                shape: .circle,
                border: Border.all(
                  color: theme.colors.mutedForeground,
                  width: 2.2,
                ),
              ),
            ),
          )
        : Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: statusColor,
              shape: .circle,
              border: Border.all(color: theme.colors.card, width: 2),
            ),
          );

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: .none,
        children: [
          glyph,
          Positioned(right: -4, bottom: -4, child: dot),
        ],
      ),
    );
  }
}
