import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_section_list.dart';
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
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );
  }

  group('DestinationConnectionSectionList', () {
    final pinned = [
      ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.sftp,
        displayName: 'Pinned Server',
        remoteAddress: 'pinned.example.com',
        username: 'admin',
        password: 'pass',
        isPinned: true,
      ),
    ];
    final other = [
      ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.webdav,
        displayName: 'Other Server',
        remoteAddress: 'other.example.com',
        username: 'user',
        password: 'pass',
        isPinned: false,
      ),
    ];

    testWidgets('renders sections when hasSections is true', (tester) async {
      ConnectionViewModel? selected;

      await tester.pumpWidget(
        buildTestWidget(
          DestinationConnectionSectionList(
            pinnedConnections: pinned,
            otherConnections: other,
            filteredConnections: [...pinned, ...other],
            hasSections: true,
            selectedId: pinned.first.id,
            onSelect: (conn) => selected = conn,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pinned Connections'), findsOneWidget);
      expect(find.text('Pinned Server'), findsOneWidget);
      expect(find.text('Other Connections'), findsOneWidget);
      expect(find.text('Other Server'), findsOneWidget);

      await tester.tap(find.text('Other Server'));
      await tester.pumpAndSettle();

      expect(selected, other.first);
    });

    testWidgets(
      'renders flat list without section headers when hasSections is false',
      (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          DestinationConnectionSectionList(
            pinnedConnections: pinned,
            otherConnections: other,
            filteredConnections: other,
            hasSections: false,
            onSelect: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pinned Connections'), findsNothing);
      expect(find.text('Other Connections'), findsNothing);
      expect(find.text('Other Server'), findsOneWidget);
    });
  });
}
