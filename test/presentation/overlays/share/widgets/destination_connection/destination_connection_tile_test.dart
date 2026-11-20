import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_tile.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

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

  group('DestinationConnectionTile', () {
    testWidgets('renders connection details and checkmark when selected', (
      tester,
    ) async {
      ConnectionViewModel? selectedConn;
      final conn = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.sftp,
        displayName: 'Prod Server',
        remoteAddress: 'prod.example.com',
        username: 'root',
        password: 'pass',
        isPinned: true,
        status: ConnectionStatus.online,
      );

      await tester.pumpWidget(
        buildTestWidget(
          DestinationConnectionTile(
            connection: conn,
            isSelected: true,
            onSelect: (c) => selectedConn = c,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Prod Server'), findsOneWidget);
      expect(find.text('prod.example.com'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.check), findsOneWidget);
      expect(find.byIcon(FLucideIcons.pin), findsOneWidget);

      await tester.tap(find.text('Prod Server'));
      await tester.pumpAndSettle();

      expect(selectedConn, conn);
    });

    testWidgets('renders unselected state without checkmark', (tester) async {
      final conn = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.webdav,
        displayName: 'Dev Server',
        remoteAddress: 'dev.example.com',
        username: 'dev',
        password: 'pass',
        isPinned: false,
      );

      await tester.pumpWidget(
        buildTestWidget(
          DestinationConnectionTile(
            connection: conn,
            isSelected: false,
            onSelect: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Dev Server'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.check), findsNothing);
      expect(find.byIcon(FLucideIcons.pin), findsNothing);
    });
  });
}
