import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/screens/add_connection/widgets/change_connection_protocol/selector.dart';
import 'package:sharehop/presentation/screens/add_connection/widgets/change_connection_protocol/sheet.dart';
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

  group('ChangeConnectionProtocolSelector', () {
    testWidgets('renders protocol name, hint and opens sheet on change tap', (
      tester,
    ) async {
      ConnectionProtocol? selected;

      await tester.pumpWidget(
        buildTestWidget(
          ChangeConnectionProtocolSelector(
            value: ConnectionProtocol.webdav,
            onChange: (p) => selected = p,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('WebDAV'), findsOneWidget);
      expect(find.text('Change'), findsOneWidget);

      await tester.tap(find.text('Change'));
      await tester.pumpAndSettle();

      expect(find.text('Select Connection Protocol'), findsOneWidget);

      await tester.tap(find.text('SFTP'));
      await tester.pumpAndSettle();

      expect(selected, ConnectionProtocol.sftp);
    });

    testWidgets('showChangeConnectionProtocolSheet alias opens sheet', (
      tester,
    ) async {
      ConnectionProtocol? selected;

      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showSelectionConnectionProtocolSheet(
                context,
                onChange: (p) => selected = p,
                selectedConnectionProtocol: ConnectionProtocol.ftp,
              ),
              child: const Text('Open Sheet'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Select Connection Protocol'), findsOneWidget);

      await tester.ensureVisible(find.text('SMB'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('SMB'));
      await tester.pumpAndSettle();

      expect(selected, ConnectionProtocol.smb);
    });
  });
}
