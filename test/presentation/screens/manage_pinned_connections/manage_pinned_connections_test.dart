import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/screens/add_connection/screen.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/pinned_connections_section.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/screen.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/sections/other_connections_manage_section.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/sections/pinned_connections_manage_section.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_empty_state.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_filter_chip.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_filter_chips.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_pinned_empty_state.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_pinned_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';
import 'package:uuid/uuid.dart';

final UuidValue _id1 = const Uuid().v7obj();
final UuidValue _id2 = const Uuid().v7obj();
final UuidValue _id3 = const Uuid().v7obj();
final UuidValue _id4 = const Uuid().v7obj();
final UuidValue _id5 = const Uuid().v7obj();

class _SampleManagePinnedConnectionsController
    extends ManagePinnedConnectionsController {
  @override
  ManagePinnedConnectionsState build() {
    return ManagePinnedConnectionsState(
      pinnedConnections: [
        ConnectionViewModel(
          id: _id1,
          displayName: 'Studio NAS',
          remoteAddress: '192.168.1.42',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.smb,
          isPinned: true,
        ),
        ConnectionViewModel(
          id: _id2,
          displayName: 'Production',
          remoteAddress: 'prod.relaydock.io',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.sftp,
          status: ConnectionStatus.ready,
          isPinned: true,
        ),
        ConnectionViewModel(
          id: _id3,
          displayName: 'Design archive',
          remoteAddress: 'dav.studio.co',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.webdav,
          isPinned: true,
        ),
      ],
      otherConnections: [
        ConnectionViewModel(
          id: _id4,
          displayName: 'Finance secure',
          remoteAddress: 'secure.finance.example',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.ftps,
          status: ConnectionStatus.ready,
          isPinned: false,
        ),
        ConnectionViewModel(
          id: _id5,
          displayName: 'Legacy media',
          remoteAddress: 'ftp.archive.studio',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.ftp,
          isPinned: false,
        ),
      ],
    );
  }

  @override
  bool pin(UuidValue id) {
    if (state.pinnedConnections.length >= 6) {
      return false;
    }

    final index = state.otherConnections.indexWhere((item) => item.id == id);
    if (index == -1) {
      return false;
    }

    final item = state.otherConnections[index]..isPinned = true;
    final other = List<ConnectionViewModel>.from(state.otherConnections)
      ..removeAt(index);
    final pinned = List<ConnectionViewModel>.from(state.pinnedConnections)
      ..add(item);

    state = state.copyWith(pinnedConnections: pinned, otherConnections: other);
    return true;
  }

  @override
  void unpin(UuidValue id) {
    final index = state.pinnedConnections.indexWhere((item) => item.id == id);
    if (index == -1) {
      return;
    }

    final item = state.pinnedConnections[index]..isPinned = false;
    final pinned = List<ConnectionViewModel>.from(state.pinnedConnections)
      ..removeAt(index);
    final other = List<ConnectionViewModel>.from(state.otherConnections)
      ..add(item);

    state = state.copyWith(pinnedConnections: pinned, otherConnections: other);
  }
}

Widget _buildTestWidget(
  Widget child, {
  ManagePinnedConnectionsController Function()? controllerFactory,
}) {
  return ProviderScope(
    overrides: [
      managePinnedConnectionsControllerProvider.overrideWith(
        controllerFactory ?? _SampleManagePinnedConnectionsController.new,
      ),
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

void main() {
  group('ManagePinnedConnectionsScreen', () {
    testWidgets('renders all screen sections and content', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const ManagePinnedConnectionsScreen()),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Manage pinned'), findsOneWidget);
      expect(find.text('Connections shown on Home'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.chevronLeft), findsOneWidget);
      expect(find.byIcon(FLucideIcons.ellipsis), findsOneWidget);

      // Callout banner
      expect(
        find.text(
          'Pinned items appear on Home for fast access. '
          'Unpin or edit a connection.',
        ),
        findsOneWidget,
      );

      // Section 1: PINNED
      expect(find.text('Pinned (3)'), findsOneWidget);
      expect(find.text('Studio NAS'), findsOneWidget);
      expect(find.text('192.168.1.42'), findsOneWidget);
      expect(find.text('Production'), findsOneWidget);
      expect(find.text('prod.relaydock.io'), findsOneWidget);
      expect(find.text('Design archive'), findsOneWidget);
      expect(find.text('dav.studio.co'), findsOneWidget);

      // Section 2: OTHER CONNECTIONS
      expect(find.text('Other Connections (2)'), findsOneWidget);
      expect(find.text('Finance secure'), findsOneWidget);
      expect(find.text('secure.finance.example'), findsOneWidget);
      expect(find.text('Legacy media'), findsOneWidget);
      expect(find.text('ftp.archive.studio'), findsOneWidget);
      expect(find.byType(ConnectionProtocolGlyph), findsNWidgets(5));
    });

    testWidgets('unpins connection when unpin button is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(const ManagePinnedConnectionsScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pinned (3)'), findsOneWidget);

      // Tap unpin button on 'Studio NAS'
      final unpinButton = find.bySemanticsLabel('Unpin Studio NAS');
      expect(unpinButton, findsOneWidget);
      await tester.tap(unpinButton);
      await tester.pumpAndSettle();

      // PINNED count should now be 2
      expect(find.text('Pinned (2)'), findsOneWidget);
      expect(find.text('Other Connections (3)'), findsOneWidget);
    });

    testWidgets('pins connection when pin button is tapped', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const ManagePinnedConnectionsScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pinned (3)'), findsOneWidget);
      expect(find.text('Other Connections (2)'), findsOneWidget);

      // Tap pin button on 'Finance secure'
      final pinButton = find.bySemanticsLabel('Pin Finance secure');
      expect(pinButton, findsOneWidget);
      await tester.tap(pinButton);
      await tester.pumpAndSettle();

      // PINNED count should now be 4
      expect(find.text('Pinned (4)'), findsOneWidget);
      expect(find.text('Other Connections (1)'), findsOneWidget);
    });

    testWidgets(
      'Home screen Manage button navigates to ManagePinnedConnectionsScreen',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(const Scaffold(body: PinnedConnectionsSection())),
        );
        await tester.pumpAndSettle();

        expect(find.text('Pinned Connections'), findsOneWidget);
        final manageButton = find.text('Manage');
        expect(manageButton, findsOneWidget);

        await tester.tap(manageButton);
        await tester.pumpAndSettle();

        expect(find.text('Manage pinned'), findsOneWidget);
        expect(find.text('Connections shown on Home'), findsOneWidget);

        // Tap back button to navigate back
        await tester.tap(find.byIcon(FLucideIcons.chevronLeft));
        await tester.pumpAndSettle();

        expect(find.text('Pinned Connections'), findsOneWidget);
      },
    );

    testWidgets('tapping Add connection button in menu navigates to '
        'AddConnectionScreen', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const ManagePinnedConnectionsScreen()),
      );
      await tester.pumpAndSettle();

      final moreButton = find.byIcon(FLucideIcons.ellipsis);
      expect(moreButton, findsOneWidget);

      await tester.tap(moreButton);
      await tester.pumpAndSettle();

      final addConnectionItem = find.text('Add connection');
      expect(addConnectionItem, findsOneWidget);
      expect(find.byIcon(FLucideIcons.plus), findsOneWidget);

      await tester.tap(addConnectionItem);
      await tester.pumpAndSettle();

      expect(find.byType(AddConnectionScreen), findsOneWidget);
    });

    testWidgets(
      'ManagePinnedHeader triggers onPressDone and onPressAddConnection',
      (tester) async {
        var doneCalled = false;
        var addCalled = false;

        await tester.pumpWidget(
          _buildTestWidget(
            ManagePinnedHeader(
              onPressDone: () => doneCalled = true,
              onPressAddConnection: () => addCalled = true,
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(FLucideIcons.chevronLeft));
        await tester.pumpAndSettle();
        expect(doneCalled, isTrue);

        await tester.tap(find.byIcon(FLucideIcons.ellipsis));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Add connection'));
        await tester.pumpAndSettle();
        expect(addCalled, isTrue);
      },
    );

    testWidgets('has access to controller and controls popover menu', (
      tester,
    ) async {
      final popoverController = FPopoverController(vsync: const TestVSync());

      await tester.pumpWidget(
        _buildTestWidget(
          ManagePinnedHeader(
            onPressDone: () {},
            controller: popoverController,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Add connection'), findsNothing);

      unawaited(popoverController.show());
      await tester.pumpAndSettle();

      expect(find.text('Add connection'), findsOneWidget);

      unawaited(popoverController.hide());
      await tester.pumpAndSettle();

      expect(find.text('Add connection'), findsNothing);

      popoverController.dispose();
    });

    testWidgets('renders ManagePinnedEmptyState with default text and icon', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestWidget(const ManagePinnedEmptyState()));
      await tester.pumpAndSettle();

      expect(find.byIcon(FLucideIcons.pinOff), findsOneWidget);
      expect(find.text('No pinned connections'), findsOneWidget);
      expect(
        find.text('Tap the pin icon below to pin a connection.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'renders ManageOtherConnectionsEmptyState with default text and icon',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(const ManageOtherConnectionsEmptyState()),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(FLucideIcons.network), findsOneWidget);
        expect(find.text('No other connections available'), findsOneWidget);
        expect(
          find.text(
            'Add a new connection or switch filter to see other connections.',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'shows ManagePinnedEmptyState when pinnedConnections is empty',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            const Scaffold(body: PinnedConnectionsManageSection()),
            controllerFactory: _EmptyPinnedController.new,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(ManagePinnedEmptyState), findsOneWidget);
      },
    );

    testWidgets(
      'shows ManageOtherConnectionsEmptyState when otherConnections is empty',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            const Scaffold(body: OtherConnectionsManageSection()),
            controllerFactory: _EmptyOtherController.new,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(ManageOtherConnectionsEmptyState), findsOneWidget);
        expect(find.text('Other Connections (0)'), findsOneWidget);
      },
    );

    testWidgets(
      'renders all protocol filter chips in other connections section',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(const ManagePinnedConnectionsScreen()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Other Connections (2)'), findsOneWidget);
        expect(find.byType(ManageOtherConnectionsFilterChips), findsOneWidget);
        expect(find.byType(ManageOtherConnectionsFilterChip), findsNWidgets(7));
        expect(find.bySemanticsLabel('Filter by All'), findsOneWidget);
        expect(find.bySemanticsLabel('Filter by FTP'), findsOneWidget);
        expect(find.bySemanticsLabel('Filter by SFTP'), findsOneWidget);
        expect(find.bySemanticsLabel('Filter by WebDAV'), findsOneWidget);
        expect(find.bySemanticsLabel('Filter by FTPS'), findsOneWidget);
        expect(find.bySemanticsLabel('Filter by NFS'), findsOneWidget);
        expect(find.bySemanticsLabel('Filter by SMB'), findsOneWidget);
      },
    );

    testWidgets(
      'filters other connections when a protocol filter chip is tapped',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(const ManagePinnedConnectionsScreen()),
        );
        await tester.pumpAndSettle();

        // Both connections initially visible
        expect(find.text('Other Connections (2)'), findsOneWidget);
        expect(find.text('Finance secure'), findsOneWidget);
        expect(find.text('Legacy media'), findsOneWidget);

        // Tap FTP filter chip
        final ftpChip = find.bySemanticsLabel('Filter by FTP');
        expect(ftpChip, findsOneWidget);
        await tester.tap(ftpChip);
        await tester.pumpAndSettle();

        // Only Legacy media (FTP) is visible, Finance secure (FTPS) is not
        expect(find.text('Other Connections (1)'), findsOneWidget);
        expect(find.text('Legacy media'), findsOneWidget);
        expect(find.text('Finance secure'), findsNothing);

        // Tap FTPS filter chip
        final ftpsChip = find.bySemanticsLabel('Filter by FTPS');
        expect(ftpsChip, findsOneWidget);
        await tester.tap(ftpsChip);
        await tester.pumpAndSettle();

        // Only Finance secure (FTPS) is visible, Legacy media (FTP) is not
        expect(find.text('Other Connections (1)'), findsOneWidget);
        expect(find.text('Finance secure'), findsOneWidget);
        expect(find.text('Legacy media'), findsNothing);
      },
    );

    testWidgets(
      'shows empty state when filtered protocol has no matching connections',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(const ManagePinnedConnectionsScreen()),
        );
        await tester.pumpAndSettle();

        // Tap WebDAV filter chip (no other connection has webdav)
        final webDavChip = find.bySemanticsLabel('Filter by WebDAV');
        expect(webDavChip, findsOneWidget);
        await tester.tap(webDavChip);
        await tester.pumpAndSettle();

        expect(find.text('Other Connections (0)'), findsOneWidget);
        expect(find.byType(ManageOtherConnectionsEmptyState), findsOneWidget);
        expect(find.text('Finance secure'), findsNothing);
        expect(find.text('Legacy media'), findsNothing);
      },
    );

    testWidgets(
      'toggles filter off when active protocol filter chip is tapped again',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(const ManagePinnedConnectionsScreen()),
        );
        await tester.pumpAndSettle();

        final ftpChip = find.bySemanticsLabel('Filter by FTP');
        await tester.tap(ftpChip);
        await tester.pumpAndSettle();

        expect(find.text('Legacy media'), findsOneWidget);
        expect(find.text('Finance secure'), findsNothing);

        // Tap FTP again to toggle off
        await tester.tap(ftpChip);
        await tester.pumpAndSettle();

        expect(find.text('Legacy media'), findsOneWidget);
        expect(find.text('Finance secure'), findsOneWidget);
      },
    );

    testWidgets('resets filter when All filter chip is tapped', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const ManagePinnedConnectionsScreen()),
      );
      await tester.pumpAndSettle();

      final ftpChip = find.bySemanticsLabel('Filter by FTP');
      await tester.tap(ftpChip);
      await tester.pumpAndSettle();

      expect(find.text('Legacy media'), findsOneWidget);
      expect(find.text('Finance secure'), findsNothing);

      // Tap All filter chip
      final allChip = find.bySemanticsLabel('Filter by All');
      await tester.tap(allChip);
      await tester.pumpAndSettle();

      expect(find.text('Legacy media'), findsOneWidget);
      expect(find.text('Finance secure'), findsOneWidget);
    });
  });
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

class _EmptyOtherController extends ManagePinnedConnectionsController {
  @override
  ManagePinnedConnectionsState build() {
    return const ManagePinnedConnectionsState(
      pinnedConnections: [],
      otherConnections: [],
    );
  }
}
