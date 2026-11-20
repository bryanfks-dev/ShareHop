import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/forms/save_connection_button.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

void main() {
  group('SaveConnectionButton', () {
    testWidgets('renders button text, security notice, and responds to tap', (
      tester,
    ) async {
      var pressed = false;
      await tester.pumpWidget(
        _buildTestWidget(
          SaveConnectionButton(
            onPress: () => pressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Save connection'), findsOneWidget);
      expect(
        find.text('Credentials stay encrypted on this device'),
        findsOneWidget,
      );
      expect(find.byIcon(FLucideIcons.plugZap), findsOneWidget);

      await tester.tap(find.text('Save connection'));
      await tester.pumpAndSettle();
      expect(pressed, isTrue);
    });

    testWidgets('shows progress indicator and disables tap when loading', (
      tester,
    ) async {
      var pressed = false;
      await tester.pumpWidget(
        _buildTestWidget(
          SaveConnectionButton(
            isLoading: true,
            onPress: () => pressed = true,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(FCircularProgress), findsOneWidget);
      expect(find.byIcon(FLucideIcons.plugZap), findsNothing);

      final button = tester.widget<FButton>(find.byType(FButton));
      expect(button.onPress, isNull);
      expect(pressed, isFalse);
    });
  });
}
