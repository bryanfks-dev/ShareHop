import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_connection_tile.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_tile_group.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_pinned_callout_banner.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_pinned_tile_group.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(
      body: SingleChildScrollView(child: child),
    ),
  );
}

void main() {
  final pinnedConn = ConnectionViewModel(
    id: const Uuid().v7obj(),
    displayName: 'Main Server',
    remoteAddress: 'https://main.server',
    username: 'admin',
    password: 'password',
    protocol: ConnectionProtocol.webdav,
    isPinned: true,
  );

  final unpinnedConn = ConnectionViewModel(
    id: const Uuid().v7obj(),
    displayName: 'Backup NAS',
    remoteAddress: '192.168.1.100',
    username: 'user',
    password: 'pwd',
    protocol: ConnectionProtocol.smb,
    isPinned: false,
  );

  group('Manage Pinned Connections Widgets', () {
    testWidgets('ManagePinnedCalloutBanner renders banner text', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const ManagePinnedCalloutBanner(),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Pinned items appear on Home for fast access. '
          'Unpin or edit a connection.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('ManageConnectionTile renders pinned state with unpin button', (
      tester,
    ) async {
      var unpinned = false;
      var edited = false;

      await tester.pumpWidget(
        _buildTestWidget(
          ManageConnectionTile(
            connection: pinnedConn,
            onPressUnpin: () => unpinned = true,
            onPressEdit: () => edited = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Main Server'), findsOneWidget);
      expect(find.text('https://main.server'), findsOneWidget);

      final unpinBtn = find.bySemanticsLabel('Unpin Main Server');
      expect(unpinBtn, findsOneWidget);
      await tester.tap(unpinBtn);
      await tester.pumpAndSettle();
      expect(unpinned, isTrue);

      final editBtn = find.bySemanticsLabel('Edit Main Server');
      expect(editBtn, findsOneWidget);
      await tester.tap(editBtn);
      await tester.pumpAndSettle();
      expect(edited, isTrue);
    });

    testWidgets('ManageConnectionTile renders unpinned state with pin button', (
      tester,
    ) async {
      var pinned = false;

      await tester.pumpWidget(
        _buildTestWidget(
          ManageConnectionTile(
            connection: unpinnedConn,
            onPressPin: () => pinned = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Backup NAS'), findsOneWidget);

      final pinBtn = find.bySemanticsLabel('Pin Backup NAS');
      expect(pinBtn, findsOneWidget);
      await tester.tap(pinBtn);
      await tester.pumpAndSettle();
      expect(pinned, isTrue);
    });

    testWidgets('ManagePinnedTileGroup and ManageOtherConnectionsTileGroup', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          Column(
            children: [
              ManagePinnedTileGroup(
                pinnedConnections: [pinnedConn],
                onPressUnpin: ({required connection}) {},
                onPressEdit: ({required connection}) {},
              ),
              ManageOtherConnectionsTileGroup(
                otherConnections: [unpinnedConn],
                onPressPin: ({required connection}) {},
                onPressEdit: ({required connection}) {},
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Main Server'), findsOneWidget);
      expect(find.text('Backup NAS'), findsOneWidget);
    });
  });
}
