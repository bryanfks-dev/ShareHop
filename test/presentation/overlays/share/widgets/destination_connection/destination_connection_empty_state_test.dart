import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_empty_state.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        ...FLocalizations.localizationsDelegates,
      ],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('DestinationConnectionEmptyState', () {
    testWidgets('renders empty state text and handles add connection action', (
      tester,
    ) async {
      var isAddCalled = false;

      await tester.pumpWidget(
        buildTestWidget(
          DestinationConnectionEmptyState(
            onAddConnection: () => isAddCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No available connections'), findsOneWidget);
      expect(
        find.text(
          'Add a connection to configure a destination for file transfers.',
        ),
        findsOneWidget,
      );
      expect(find.text('Add connection'), findsOneWidget);

      await tester.tap(find.text('Add connection'));
      await tester.pumpAndSettle();

      expect(isAddCalled, isTrue);
    });

    testWidgets('renders without action button when onAddConnection is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(const DestinationConnectionEmptyState()),
      );
      await tester.pumpAndSettle();

      expect(find.text('No available connections'), findsOneWidget);
      expect(find.text('Add connection'), findsNothing);
    });
  });
}
