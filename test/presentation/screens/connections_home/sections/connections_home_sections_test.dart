import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/new_connection_shortcut_section.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/pinned_connections_section.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/quick_connect_section.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph_with_undertext.dart';
import 'package:uuid/uuid.dart';

class _MockManagePinnedConnectionsController
    extends ManagePinnedConnectionsController {
  new({required this.pinned});

  final List<ConnectionViewModel> pinned;

  @override
  ManagePinnedConnectionsState build() {
    return ManagePinnedConnectionsState(
      pinnedConnections: pinned,
      otherConnections: const [],
    );
  }
}

Widget _buildTestWidget({
  required Widget child,
  List<ConnectionViewModel> pinned = const [],
}) {
  return ProviderScope(
    overrides: [
      managePinnedConnectionsControllerProvider.overrideWith(
        () => _MockManagePinnedConnectionsController(pinned: pinned),
      ),
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
    displayName: 'Home Server',
    remoteAddress: 'https://home.server',
    username: 'admin',
    password: 'password',
    protocol: ConnectionProtocol.webdav,
    isPinned: true,
  );

  group('Connections Home Sections', () {
    testWidgets('PinnedConnectionsSection renders empty state', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const PinnedConnectionsSection(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pinned Connections'), findsOneWidget);
      expect(find.text('Manage'), findsOneWidget);
      expect(find.text('No pinned connections'), findsOneWidget);
    });

    testWidgets('PinnedConnectionsSection renders pinned connections list', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const PinnedConnectionsSection(),
          pinned: [pinnedConn],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home Server'), findsOneWidget);
      expect(find.text('https://home.server'), findsOneWidget);
    });

    testWidgets('QuickConnectSection renders input field', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const QuickConnectSection(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Host or server address'), findsOneWidget);
      expect(find.text('Connect'), findsOneWidget);
    });

    testWidgets('NewConnectionShortcutSection renders protocol buttons', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const NewConnectionShortcutSection(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('New Connection'), findsOneWidget);
      expect(
        find.byType(ConnectionProtocolGlyphWithUndertext),
        findsNWidgets(3),
      );
      expect(find.text('SFTP'), findsWidgets);
      expect(find.text('FTP'), findsWidgets);
      expect(find.text('WebDAV'), findsWidgets);
    });
  });
}
