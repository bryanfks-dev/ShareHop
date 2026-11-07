import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connections_home/screen.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/new_connection_shortcut_section.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/pinned_connections_section.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/quick_connect_section.dart';
import 'package:sharehop/presentation/screens/connections_home/widgets/connections_home_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';

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
  });
}
