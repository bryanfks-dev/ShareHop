import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/add_connection_card.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('AddConnectionCard', () {
    testWidgets('renders card content and handles open press', (tester) async {
      var isOpenCalled = false;

      await tester.pumpWidget(
        buildTestWidget(
          AddConnectionCard(onPressOpen: () => isOpenCalled = true),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Add new connection'), findsOneWidget);
      expect(find.text('Open ShareHop to configure it'), findsOneWidget);
      expect(find.text('Open'), findsOneWidget);

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(isOpenCalled, isTrue);
    });
  });
}
