import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';
import 'package:sharehop/presentation/widgets/connection/constants/connection_protocol_glyph.dart';

class ConnectionProtocolGlyphWithUndertext extends StatelessWidget {
  const new({
    required this.connectionProtocol,
    this.size = kConnectionProtocolGlyphDefaultSize,
    this.onPress,
    super.key,
  });

  final ConnectionProtocol connectionProtocol;
  final double size;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FTappable(
      onPress: onPress,
      child: Column(
        spacing: Spacing.sm,
        children: [
          ConnectionProtocolGlyph(
            connectionProtocol: connectionProtocol,
            size: size,
          ),
          Text(
            connectionProtocol.name,
            style: theme.typography.body.xs2.copyWith(
              color: theme.colors.foreground,
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    );
  }
}
