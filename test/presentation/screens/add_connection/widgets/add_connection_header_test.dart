import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/add_connection/widgets/add_connection_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        ...FLocalizations.localizationsDelegates,
      ],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: child),
    );
  }

  group('AddConnectionHeader', () {
    testWidgets('renders title and handles back button press', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const Scaffold(body: AddConnectionHeader()),
                  ),
                );
              },
              child: const Text('Push'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Push'));
      await tester.pumpAndSettle();

      expect(find.text('Add connection'), findsOneWidget);
      expect(find.text('Connection profile'), findsOneWidget);

      await tester.tap(find.byIcon(FLucideIcons.chevronLeft));
      await tester.pumpAndSettle();

      expect(find.text('Push'), findsOneWidget);
    });
  });
}
