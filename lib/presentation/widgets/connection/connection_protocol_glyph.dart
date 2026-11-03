import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/constants/connection_protocol_glyph.dart';

class ConnectionProtocolGlyph extends StatelessWidget {
  const new({
    required this.connectionProtocol,
    this.size = kConnectionProtocolGlyphDefaultSize,
    super.key,
  });

  final ConnectionProtocol connectionProtocol;
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
        backgroundColor = theme.colors.app.accentRed;
      case .nfs:
        backgroundColor = theme.colors.app.accentPurple;
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
        foregroundColor = theme.colors.app.accentRedForeground;
      case .nfs:
        foregroundColor = theme.colors.app.accentPurpleForeground;
    }

    return Container(
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
  }
}
