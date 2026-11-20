import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/sections/other_connections_manage_section.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/sections/pinned_connections_manage_section.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

class _MockManagePinnedConnectionsController
    extends ManagePinnedConnectionsController {
  new({
    required this.pinned,
    required this.other,
  });

  final List<ConnectionViewModel> pinned;
  final List<ConnectionViewModel> other;

  @override
  ManagePinnedConnectionsState build() {
    return ManagePinnedConnectionsState(
      pinnedConnections: pinned,
      otherConnections: other,
    );
  }
}

Widget _buildTestWidget({
  required Widget child,
  required ManagePinnedConnectionsController Function() createController,
}) {
  return ProviderScope(
    overrides: [
      managePinnedConnectionsControllerProvider.overrideWith(createController),
    ],
    child: MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: Scaffold(
        body: SingleChildScrollView(child: child),
      ),
    ),
  );
}

void main() {
  final pinnedConn = ConnectionViewModel(
    id: const Uuid().v7obj(),
    displayName: 'Pinned Alpha',
    remoteAddress: '192.168.1.1',
    username: 'admin',
    password: 'password',
    protocol: ConnectionProtocol.webdav,
    isPinned: true,
  );

  final otherConn = ConnectionViewModel(
    id: const Uuid().v7obj(),
    displayName: 'Other Beta',
    remoteAddress: '192.168.1.2',
    username: 'admin',
    password: 'password',
    protocol: ConnectionProtocol.smb,
    isPinned: false,
  );

  group('Manage Pinned Connections Sections', () {
    testWidgets('PinnedConnectionsManageSection renders empty state', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const PinnedConnectionsManageSection(),
          createController: () => _MockManagePinnedConnectionsController(
            pinned: [],
            other: [],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pinned (0)'), findsOneWidget);
      expect(find.text('No pinned connections'), findsOneWidget);
    });

    testWidgets('PinnedConnectionsManageSection renders pinned connections', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const PinnedConnectionsManageSection(),
          createController: () => _MockManagePinnedConnectionsController(
            pinned: [pinnedConn],
            other: [],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pinned (1)'), findsOneWidget);
      expect(find.text('Pinned Alpha'), findsOneWidget);
    });

    testWidgets('OtherConnectionsManageSection renders empty state', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const OtherConnectionsManageSection(),
          createController: () => _MockManagePinnedConnectionsController(
            pinned: [],
            other: [],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Other Connections (0)'), findsOneWidget);
      expect(find.text('No other connections available'), findsOneWidget);
    });

    testWidgets('OtherConnectionsManageSection renders other connections', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const OtherConnectionsManageSection(),
          createController: () => _MockManagePinnedConnectionsController(
            pinned: [],
            other: [otherConn],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Other Connections (1)'), findsOneWidget);
      expect(find.text('Other Beta'), findsOneWidget);
    });
  });
}
