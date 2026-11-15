import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/confirmation_delete_connection_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: FToaster(child: c!),
    ),
    home: child,
  );
}

void main() {
  group('ConfirmationDeleteConnectionSheet', () {
    testWidgets('renders connection name and action buttons', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                await showConfirmationDeleteConnectionSheet(
                  context,
                  connectionName: 'Production Server',
                  onConfirm: () {},
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Delete Connection'), findsOneWidget);
      expect(
        find.text(
          'Are you sure you want to delete "Production Server"? '
          'This connection and its credentials will be '
          'permanently removed.',
        ),
        findsOneWidget,
      );
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('tapping Cancel dismisses sheet without calling onConfirm', (
      tester,
    ) async {
      var confirmed = false;

      await tester.pumpWidget(
        _buildTestWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                await showConfirmationDeleteConnectionSheet(
                  context,
                  connectionName: 'Production Server',
                  onConfirm: () {
                    confirmed = true;
                  },
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(confirmed, isFalse);
      expect(find.text('Delete Connection'), findsNothing);
    });

    testWidgets('tapping Delete invokes onConfirm and dismisses sheet', (
      tester,
    ) async {
      var confirmed = false;

      await tester.pumpWidget(
        _buildTestWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                await showConfirmationDeleteConnectionSheet(
                  context,
                  connectionName: 'Production Server',
                  onConfirm: () {
                    confirmed = true;
                  },
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(confirmed, isTrue);
      expect(find.text('Delete Connection'), findsNothing);
    });
  });
}
