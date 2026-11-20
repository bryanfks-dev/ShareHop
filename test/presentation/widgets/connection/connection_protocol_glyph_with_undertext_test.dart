import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph_with_undertext.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('ConnectionProtocolGlyphWithUndertext', () {
    testWidgets('renders glyph and undertext label, handles press', (
      tester,
    ) async {
      var isPressed = false;

      await tester.pumpWidget(
        buildTestWidget(
          ConnectionProtocolGlyphWithUndertext(
            connectionProtocol: ConnectionProtocol.webdav,
            onPress: () => isPressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('WebDAV'), findsOneWidget);

      await tester.tap(find.text('WebDAV'));
      await tester.pumpAndSettle();

      expect(isPressed, isTrue);
    });
  });
}
