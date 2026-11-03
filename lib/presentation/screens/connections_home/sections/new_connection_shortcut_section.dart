import 'package:flutter/material.dart';
import 'package:forui/theme.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/add_connection/screen.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph_with_undertext.dart';
import 'package:sharehop/presentation/widgets/layout/information_feature_not_available_sheet.dart';

class NewConnectionShortcutSection extends StatelessWidget {
  const new({super.key});

  static const _kConnectionProtocolGlyphSize = 48.0;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    Future<void> handleOnPressSftp() async {
      await showInformationFeatureNotAvailableSheet(context);
    }

    Future<void> handleOnPressFtp() async {
      await showInformationFeatureNotAvailableSheet(context);
    }

    void handleOnPressWebDav() {
      context.navigator.push(
        MaterialPageRoute<void>(
          builder: (context) => const AddConnectionScreen(),
        ),
      );
    }

    return Column(
      spacing: Spacing.lg,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Text(
          'NEW CONNECTION',
          style: theme.typography.display.xs.copyWith(
            color: theme.colors.foreground,
            fontWeight: .w700,
          ),
        ),
        Flex(
          direction: .horizontal,
          spacing: Spacing.xl,
          children: [
            ConnectionProtocolGlyphWithUndertext(
              connectionProtocol: ConnectionProtocol.sftp,
              size: _kConnectionProtocolGlyphSize,
              onPress: handleOnPressSftp,
            ),
            ConnectionProtocolGlyphWithUndertext(
              connectionProtocol: ConnectionProtocol.ftp,
              size: _kConnectionProtocolGlyphSize,
              onPress: handleOnPressFtp,
            ),
            ConnectionProtocolGlyphWithUndertext(
              connectionProtocol: ConnectionProtocol.webdav,
              size: _kConnectionProtocolGlyphSize,
              onPress: handleOnPressWebDav,
            ),
          ],
        ),
      ],
    );
  }
}
