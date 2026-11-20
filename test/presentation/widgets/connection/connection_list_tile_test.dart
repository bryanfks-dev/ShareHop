import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/screens/connection_detail/screen.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_list_tile.dart';
import 'package:uuid/uuid.dart';

class _TestNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushedRoutes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }
}

void main() {
  Widget buildTestWidget(
    Widget child, {
    NavigatorObserver? observer,
  }) {
    return ProviderScope(
      child: MaterialApp(
        localizationsDelegates: const [
          ...FLocalizations.localizationsDelegates,
        ],
        navigatorObservers: [?observer],
        builder: (context, c) => FTheme(data: lightTheme, child: c!),
        home: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    );
  }

  group('ConnectionListTile', () {
    testWidgets('renders list of connections and navigates on tap', (
      tester,
    ) async {
      final observer = _TestNavigatorObserver();
      final connections = [
        ConnectionViewModel(
          id: const Uuid().v7obj(),
          protocol: ConnectionProtocol.webdav,
          displayName: 'Nextcloud Storage',
          remoteAddress: 'cloud.example.com',
          username: 'user',
          password: 'pass',
          isPinned: false,
          rootPath: '/remote.php/webdav',
          status: ConnectionStatus.online,
        ),
        ConnectionViewModel(
          id: const Uuid().v7obj(),
          protocol: ConnectionProtocol.sftp,
          displayName: 'Backup Server',
          remoteAddress: 'backup.example.com',
          username: 'admin',
          password: 'pass',
          isPinned: true,
          rootPath: '/var/backup',
        ),
      ];

      await tester.pumpWidget(
        buildTestWidget(
          ConnectionListTile(connections: connections),
          observer: observer,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Nextcloud Storage'), findsOneWidget);
      expect(find.text('cloud.example.com'), findsOneWidget);
      expect(find.text('Backup Server'), findsOneWidget);
      expect(find.text('backup.example.com'), findsOneWidget);

      await tester.tap(find.text('Nextcloud Storage'));
      await tester.pumpAndSettle();

      expect(
        observer.pushedRoutes.any(
          (r) => r.settings.name == null && r is MaterialPageRoute,
        ),
        isTrue,
      );
      expect(find.byType(ConnectionDetailScreen), findsOneWidget);
    });
  });
}
