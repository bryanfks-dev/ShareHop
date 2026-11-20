import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connections_home/screen.dart';
import 'package:sharehop/presentation/screens/settings/screen.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/screen.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/layout/main_shell.dart';

void main() {
  Widget buildTestWidget() {
    return ProviderScope(
      child: MaterialApp(
        localizationsDelegates: const [
          ...FLocalizations.localizationsDelegates,
        ],
        builder: (context, c) => FTheme(data: lightTheme, child: c!),
        home: const Scaffold(body: MainShell()),
      ),
    );
  }

  group('MainShell', () {
    testWidgets('renders initial tab Connections and switches tabs on tap', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(ConnectionsHomeScreen), findsOneWidget);
      expect(
        find.byType(TransferActivitiesScreen, skipOffstage: false),
        findsOneWidget,
      );
      expect(
        find.byType(SettingsScreen, skipOffstage: false),
        findsOneWidget,
      );

      // Tap on Transfers tab
      await tester.tap(find.text('Transfers'));
      await tester.pumpAndSettle();

      final indexedStack = tester.widget<IndexedStack>(
        find.byType(IndexedStack),
      );
      expect(indexedStack.index, 1);
      expect(find.byType(TransferActivitiesScreen), findsOneWidget);

      // Tap on Settings tab
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      final updatedStack = tester.widget<IndexedStack>(
        find.byType(IndexedStack),
      );
      expect(updatedStack.index, 2);
    });
  });
}
