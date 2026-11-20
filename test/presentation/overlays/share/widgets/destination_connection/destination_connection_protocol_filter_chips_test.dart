import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_protocol_filter_chips.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        ...FLocalizations.localizationsDelegates,
      ],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('DestinationConnectionProtocolFilterChips', () {
    testWidgets('renders filter chips and handles selection', (tester) async {
      ConnectionProtocol? selected;
      const protocols = [ConnectionProtocol.sftp, ConnectionProtocol.webdav];

      await tester.pumpWidget(
        buildTestWidget(
          DestinationConnectionProtocolFilterChips(
            protocols: protocols,
            selectedProtocol: ConnectionProtocol.sftp,
            onSelectProtocol: (p) => selected = p,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('All'), findsOneWidget);
      expect(find.text('SFTP'), findsOneWidget);
      expect(find.text('WebDAV'), findsOneWidget);

      await tester.tap(find.text('WebDAV'));
      await tester.pumpAndSettle();
      expect(selected, ConnectionProtocol.webdav);

      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();
      expect(selected, isNull);
    });
  });
}
