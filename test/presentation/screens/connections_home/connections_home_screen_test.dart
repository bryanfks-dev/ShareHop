import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/screens/connections_home/screen.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/new_connection_shortcut_section.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/pinned_connections_section.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/quick_connect_section.dart';
import 'package:sharehop/presentation/screens/connections_home/widgets/connections_home_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_list_empty_state.dart';
import 'package:sharehop/presentation/widgets/connection/connection_list_tile.dart';
import 'package:uuid/uuid.dart';

Widget _buildTestWidget(
  Widget child, {
  ManagePinnedConnectionsController Function()? controllerFactory,
}) {
  return ProviderScope(
    overrides: [
      if (controllerFactory != null)
        managePinnedConnectionsControllerProvider
            .overrideWith(controllerFactory),
    ],
    child: MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: child,
    ),
  );
}

class _PresetPinnedController extends ManagePinnedConnectionsController {
  @override
  ManagePinnedConnectionsState build() {
    return ManagePinnedConnectionsState(
      pinnedConnections: [
        ConnectionViewModel(
          id: const Uuid().v7obj(),
          displayName: 'Work WebDAV',
          remoteAddress: 'https://dav.work.com',
          username: 'worker',
          password: 'secret',
          protocol: ConnectionProtocol.webdav,
          isPinned: true,
        ),
      ],
      otherConnections: const [],
    );
  }
}

class _EmptyPinnedController extends ManagePinnedConnectionsController {
  @override
  ManagePinnedConnectionsState build() {
    return const ManagePinnedConnectionsState(
      pinnedConnections: [],
      otherConnections: [],
    );
  }
}

void main() {
  group('ConnectionsHomeScreen', () {
    testWidgets('renders all main sections and header', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const ConnectionsHomeScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(ConnectionsHomeHeader), findsOneWidget);
      expect(find.byType(QuickConnectSection), findsOneWidget);
      expect(find.byType(PinnedConnectionsSection), findsOneWidget);
      expect(find.byType(NewConnectionShortcutSection), findsOneWidget);

      expect(find.text('Pinned Connections'), findsOneWidget);
      expect(find.text('New Connection'), findsOneWidget);
    });

    testWidgets('renders ConnectionListEmptyState when pinned list is empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const ConnectionsHomeScreen(),
          controllerFactory: _EmptyPinnedController.new,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ConnectionListEmptyState), findsOneWidget);
      expect(find.text('No pinned connections'), findsOneWidget);
    });

    testWidgets('renders ConnectionListTile when pinned connections exist', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const ConnectionsHomeScreen(),
          controllerFactory: _PresetPinnedController.new,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ConnectionListTile), findsOneWidget);
      expect(find.text('Work WebDAV'), findsOneWidget);
      expect(find.text('https://dav.work.com'), findsOneWidget);
    });
  });
}
