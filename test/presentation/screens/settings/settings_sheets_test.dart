import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/settings/widgets/confirmation_clear_cache_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/information_biometrics_unavailable_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget({required WidgetBuilder builder}) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: FToaster(child: c!),
    ),
    home: Scaffold(
      body: Builder(builder: builder),
    ),
  );
}

void main() {
  group('ConfirmationClearCacheSheet', () {
    testWidgets('shows sheet and invokes onConfirm when confirmed', (
      tester,
    ) async {
      var confirmed = false;

      await tester.pumpWidget(
        _buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () => showConfirmationClearCacheSheet(
              context,
              onConfirm: () => confirmed = true,
            ),
            child: const Text('Clear Cache'),
          ),
        ),
      );

      await tester.tap(find.text('Clear Cache'));
      await tester.pumpAndSettle();

      expect(find.text('Clear Cache'), findsWidgets);
      expect(
        find.text(
          'Are you sure you want to clear temporary cache files? '
          'This will free up memory and storage space.',
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('Clear'));
      await tester.pumpAndSettle();

      expect(confirmed, isTrue);
    });

    testWidgets('dismisses sheet when cancel is tapped', (tester) async {
      var confirmed = false;

      await tester.pumpWidget(
        _buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () => showConfirmationClearCacheSheet(
              context,
              onConfirm: () => confirmed = true,
            ),
            child: const Text('Clear Cache Button'),
          ),
        ),
      );

      await tester.tap(find.text('Clear Cache Button'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(confirmed, isFalse);
    });
  });

  group('InformationBiometricsUnavailableSheet', () {
    testWidgets('shows sheet and dismisses on button tap', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () => showInformationBiometricsUnavailableSheet(context),
            child: const Text('Show Biometrics Sheet'),
          ),
        ),
      );

      await tester.tap(find.text('Show Biometrics Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Biometrics Unavailable'), findsOneWidget);
      expect(
        find.text(
          'Biometric authentication is not supported or not enrolled on '
          'this device.',
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Biometrics Unavailable'), findsNothing);
    });
  });
}
