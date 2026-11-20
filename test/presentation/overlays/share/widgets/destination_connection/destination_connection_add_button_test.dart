import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_add_button.dart';
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

  group('DestinationConnectionAddButton', () {
    testWidgets('renders button text and triggers onAddConnection', (
      tester,
    ) async {
      var isAddCalled = false;

      await tester.pumpWidget(
        buildTestWidget(
          DestinationConnectionAddButton(
            onAddConnection: () => isAddCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Add New Connection'), findsOneWidget);

      await tester.tap(find.text('Add New Connection'));
      await tester.pumpAndSettle();

      expect(isAddCalled, isTrue);
    });
  });
}
