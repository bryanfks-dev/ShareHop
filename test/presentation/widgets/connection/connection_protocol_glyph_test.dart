import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph_with_undertext.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('ConnectionProtocolGlyph', () {
    testWidgets('renders short name glyph for each protocol', (tester) async {
      for (final protocol in ConnectionProtocol.values) {
        await tester.pumpWidget(
          _buildTestWidget(
            ConnectionProtocolGlyph(
              connectionProtocol: protocol,
              status: ConnectionStatus.online,
            ),
          ),
        );

        expect(find.byType(ConnectionProtocolGlyph), findsOneWidget);
      }
    });
  });

  group('ConnectionProtocolGlyphWithUndertext', () {
    testWidgets('renders protocol glyph with label underneath', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const ConnectionProtocolGlyphWithUndertext(
            connectionProtocol: ConnectionProtocol.webdav,
          ),
        ),
      );

      expect(find.text('WebDAV'), findsOneWidget);
      expect(find.byType(ConnectionProtocolGlyph), findsOneWidget);
    });
  });
}
