import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/enums/navigation_tab.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/layout/footer.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(bottomNavigationBar: child),
  );
}

void main() {
  group('Footer', () {
    testWidgets('renders all navigation items', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const Footer()),
      );

      expect(find.text('Connections'), findsOneWidget);
      expect(find.text('Transfers'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('triggers onNavigationTabChange when an item is tapped', (
      tester,
    ) async {
      NavigationTab? changedTab;

      await tester.pumpWidget(
        _buildTestWidget(
          Footer(
            onNavigationTabChange: (tab) => changedTab = tab,
          ),
        ),
      );

      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(changedTab, NavigationTab.settings);
    });
  });
}
