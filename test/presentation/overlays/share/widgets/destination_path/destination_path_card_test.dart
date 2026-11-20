import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_path/destination_path_card.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: FToaster(child: c!),
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

void main() {
  group('DestinationPathCard', () {
    testWidgets('renders current destination path and browse button', (
      tester,
    ) async {
      var browsed = false;
      await tester.pumpWidget(
        _buildTestWidget(
          DestinationPathCard(
            path: '/remote/documents',
            onBrowse: () => browsed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('/remote/documents'), findsOneWidget);
      expect(find.text('Browse'), findsOneWidget);

      await tester.tap(find.text('Browse'));
      await tester.pumpAndSettle();
      expect(browsed, isTrue);
    });
  });
}
