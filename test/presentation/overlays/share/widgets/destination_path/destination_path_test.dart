import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_path/destination_path_card.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_path/destination_path_picker_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('DestinationPathPickerSheet', () {
    testWidgets(
      'showDestinationPathPickerSheet opens and returns confirmed path',
      (tester) async {
        String? returnedPath;

        await tester.pumpWidget(
          buildTestWidget(
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  returnedPath = await showDestinationPathPickerSheet(
                    context,
                    initialPath: '/initial/path',
                  );
                },
                child: const Text('Open Picker'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Open Picker'));
        await tester.pumpAndSettle();

        expect(find.text('Destination Path'), findsOneWidget);
        expect(find.text('Confirm path'), findsOneWidget);

        await tester.enterText(
          find.byType(EditableText),
          '/new/confirmed/path',
        );
        await tester.tap(find.text('Confirm path'));
        await tester.pumpAndSettle();

        expect(returnedPath, '/new/confirmed/path');
        expect(find.text('Destination Path'), findsNothing);
      },
    );

    testWidgets('showDestinationPathSheet alias also opens and returns path', (
      tester,
    ) async {
      String? returnedPath;

      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                returnedPath = await showDestinationPathSheet(
                  context,
                  initialPath: '/alias/path',
                );
              },
              child: const Text('Open Alias'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Alias'));
      await tester.pumpAndSettle();

      expect(find.text('Destination Path'), findsOneWidget);

      await tester.enterText(find.byType(EditableText), '/alias/confirmed');
      await tester.tap(find.text('Confirm path'));
      await tester.pumpAndSettle();

      expect(returnedPath, '/alias/confirmed');
    });
  });

  group('DestinationPathCard', () {
    testWidgets('renders initial path correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DestinationPathCard(path: '/default/destination'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('/default/destination'), findsOneWidget);
      expect(find.text('Browse'), findsOneWidget);
    });

    testWidgets('opens sheet and updates path without relying on callbacks', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(const DestinationPathCard(path: '/var/www/uploads')),
      );
      await tester.pumpAndSettle();

      expect(find.text('/var/www/uploads'), findsOneWidget);

      // Tap browse to open the sheet
      await tester.tap(find.text('Browse'));
      await tester.pumpAndSettle();

      expect(find.text('Destination Path'), findsOneWidget);
      expect(find.text('Confirm path'), findsOneWidget);

      // Enter new path and confirm
      await tester.enterText(find.byType(EditableText), '/var/www/releases');
      await tester.tap(find.text('Confirm path'));
      await tester.pumpAndSettle();

      // Card should now display the new path without requiring a callback
      expect(find.text('/var/www/releases'), findsOneWidget);
      expect(find.text('/var/www/uploads'), findsNothing);
    });

    testWidgets('notifies optional onPathChanged and onBrowse if provided', (
      tester,
    ) async {
      var browseCalled = false;
      String? changedPath;

      await tester.pumpWidget(
        buildTestWidget(
          DestinationPathCard(
            path: '/initial',
            onBrowse: () => browseCalled = true,
            onPathChanged: (p) => changedPath = p,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Browse'));
      await tester.pumpAndSettle();
      expect(browseCalled, isTrue);

      await tester.enterText(find.byType(EditableText), '/updated');
      await tester.tap(find.text('Confirm path'));
      await tester.pumpAndSettle();

      expect(changedPath, '/updated');
      expect(find.text('/updated'), findsOneWidget);
    });
  });
}
