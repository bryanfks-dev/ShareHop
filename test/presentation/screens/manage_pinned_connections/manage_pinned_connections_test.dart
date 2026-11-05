import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/pinned_connections_section.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/screen.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/sections/other_connections_manage_section.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/sections/pinned_connections_manage_section.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_empty_state.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_pinned_empty_state.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';

Widget _buildTestWidget(Widget child) {
  return ProviderScope(
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
  group('ManagePinnedConnectionsController', () {
    test('initializes with 3 pinned and 2 other connections', () {
      final container = ProviderContainer();
      final state = container.read(managePinnedConnectionsControllerProvider);

      expect(state.pinnedConnections.length, 3);
      expect(state.otherConnections.length, 2);
      expect(state.pinnedConnections[0].displayName, 'Studio NAS');
      expect(state.pinnedConnections[1].displayName, 'Production');
      expect(state.pinnedConnections[2].displayName, 'Design archive');
      expect(state.otherConnections[0].displayName, 'Finance secure');
      expect(state.otherConnections[1].displayName, 'Legacy media');
    });

    test('unpins a connection correctly', () {
      final container = ProviderContainer();
      container
          .read(managePinnedConnectionsControllerProvider.notifier)
          .unpin('1');

      final state = container.read(managePinnedConnectionsControllerProvider);
      expect(state.pinnedConnections.length, 2);
      expect(state.otherConnections.length, 3);
      expect(state.otherConnections.any((c) => c.id == '1'), isTrue);
    });

    test('pins a connection correctly', () {
      final container = ProviderContainer();
      final controller = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );

      final success = controller.pin('4');

      expect(success, isTrue);
      final state = container.read(managePinnedConnectionsControllerProvider);
      expect(state.pinnedConnections.length, 4);
      expect(state.otherConnections.length, 1);
      expect(state.pinnedConnections.any((c) => c.id == '4'), isTrue);
    });

    test('enforces limit of 6 pinned connections', () {
      final container = ProviderContainer();
      final controller =
          container.read(managePinnedConnectionsControllerProvider.notifier)
            ..pin('4')
            ..pin('5');

      var state = container.read(managePinnedConnectionsControllerProvider);
      expect(state.pinnedConnections.length, 5);

      controller
        ..unpin('1')
        ..pin('1');
      state = container.read(managePinnedConnectionsControllerProvider);
      expect(state.pinnedConnections.length, 5);
    });
  });

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

      // Callout banner
      expect(
        find.text(
          'Pinned items appear on Home for fast access. '
          'Drag to reorder, unpin, or edit a connection.',
        ),
        findsOneWidget,
      );

      // Section 1: PINNED
      expect(find.text('PINNED (3)'), findsOneWidget);
      expect(find.text('Studio NAS'), findsOneWidget);
      expect(find.text('192.168.1.42'), findsOneWidget);
      expect(find.text('Production'), findsOneWidget);
      expect(find.text('prod.relaydock.io'), findsOneWidget);
      expect(find.text('Design archive'), findsOneWidget);
      expect(find.text('dav.studio.co'), findsOneWidget);

      // Section 2: OTHER CONNECTIONS
      expect(find.text('OTHER CONNECTIONS'), findsOneWidget);
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

      expect(find.text('PINNED (3)'), findsOneWidget);

      // Tap unpin button on 'Studio NAS'
      final unpinButton = find.bySemanticsLabel('Unpin Studio NAS');
      expect(unpinButton, findsOneWidget);
      await tester.tap(unpinButton);
      await tester.pumpAndSettle();

      // PINNED count should now be 2
      expect(find.text('PINNED (2)'), findsOneWidget);
    });

    testWidgets('pins connection when pin button is tapped', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const ManagePinnedConnectionsScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('PINNED (3)'), findsOneWidget);

      // Tap pin button on 'Finance secure'
      final pinButton = find.bySemanticsLabel('Pin Finance secure');
      expect(pinButton, findsOneWidget);
      await tester.tap(pinButton);
      await tester.pumpAndSettle();

      // PINNED count should now be 4
      expect(find.text('PINNED (4)'), findsOneWidget);
    });

    testWidgets(
      'Home screen Manage button navigates to ManagePinnedConnectionsScreen',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(const Scaffold(body: PinnedConnectionsSection())),
        );
        await tester.pumpAndSettle();

        expect(find.text('PINNED CONNECTIONS'), findsOneWidget);
        final manageButton = find.text('Manage');
        expect(manageButton, findsOneWidget);

        await tester.tap(manageButton);
        await tester.pumpAndSettle();

        expect(find.text('Manage pinned'), findsOneWidget);
        expect(find.text('Connections shown on Home'), findsOneWidget);

        // Tap back button to navigate back
        await tester.tap(find.byIcon(FLucideIcons.chevronLeft));
        await tester.pumpAndSettle();

        expect(find.text('PINNED CONNECTIONS'), findsOneWidget);
      },
    );

    testWidgets('renders ManagePinnedEmptyState with default and custom text', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestWidget(const ManagePinnedEmptyState()));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'No pinned connections.\n'
          'Tap the pin icon below to pin a connection.',
        ),
        findsOneWidget,
      );

      await tester.pumpWidget(
        _buildTestWidget(
          const ManagePinnedEmptyState(message: 'Custom pinned empty'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Custom pinned empty'), findsOneWidget);
    });

    testWidgets(
      'renders ManageOtherConnectionsEmptyState with default and custom text',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(const ManageOtherConnectionsEmptyState()),
        );
        await tester.pumpAndSettle();

        expect(find.text('No other connections available.'), findsOneWidget);

        await tester.pumpWidget(
          _buildTestWidget(
            const ManageOtherConnectionsEmptyState(
              message: 'Custom other empty',
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Custom other empty'), findsOneWidget);
      },
    );

    testWidgets(
      'renders ManagePinnedEmptyState when pinnedConnections is empty',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              managePinnedConnectionsControllerProvider.overrideWith(
                _EmptyPinnedController.new,
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                ...FLocalizations.localizationsDelegates,
              ],
              builder: (context, c) => FTheme(
                data: lightTheme,
                child: FToaster(child: c!),
              ),
              home: const Scaffold(body: PinnedConnectionsManageSection()),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(ManagePinnedEmptyState), findsOneWidget);
      },
    );

    testWidgets(
      'renders ManageOtherConnectionsEmptyState when otherConnections is empty',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              managePinnedConnectionsControllerProvider.overrideWith(
                _EmptyOtherController.new,
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                ...FLocalizations.localizationsDelegates,
              ],
              builder: (context, c) => FTheme(
                data: lightTheme,
                child: FToaster(child: c!),
              ),
              home: const Scaffold(body: OtherConnectionsManageSection()),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(ManageOtherConnectionsEmptyState), findsOneWidget);
      },
    );
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
