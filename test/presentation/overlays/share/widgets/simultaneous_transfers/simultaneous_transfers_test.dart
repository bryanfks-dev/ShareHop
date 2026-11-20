import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/simultaneous_transfers/simultaneous_transfers_card.dart';
import 'package:sharehop/presentation/overlays/share/widgets/simultaneous_transfers/simultaneous_transfers_picker_sheet.dart';
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

  group('SimultaneousTransfersPickerSheet', () {
    testWidgets(
      'showSimultaneousTransfersPickerSheet opens and returns selected limit',
      (tester) async {
        int? returnedLimit;

        await tester.pumpWidget(
          buildTestWidget(
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  returnedLimit = await showSimultaneousTransfersPickerSheet(
                    context,
                    currentLimit: 3,
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

        expect(
          find.text('Select simultaneous transfers limit'),
          findsOneWidget,
        );
        expect(find.text('1 transfer(s)'), findsOneWidget);
        expect(find.text('2 transfer(s)'), findsOneWidget);
        expect(find.text('3 transfer(s)'), findsOneWidget);
        expect(find.text('4 transfer(s)'), findsOneWidget);
        expect(find.text('5 transfer(s)'), findsOneWidget);

        await tester.tap(find.text('5 transfer(s)'));
        await tester.pumpAndSettle();

        expect(returnedLimit, 5);
        expect(find.text('Select simultaneous transfers limit'), findsNothing);
      },
    );

    testWidgets(
      'showSimultaneousTransfersPickerSheet dismisses on barrier tap',
      (tester) async {
        int? returnedLimit;

        await tester.pumpWidget(
          buildTestWidget(
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  returnedLimit = await showSimultaneousTransfersPickerSheet(
                    context,
                    currentLimit: 2,
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

        expect(
          find.text('Select simultaneous transfers limit'),
          findsOneWidget,
        );

        // Tap barrier to dismiss
        await tester.tapAt(const Offset(10, 10));
        await tester.pumpAndSettle();

        expect(returnedLimit, isNull);
        expect(find.text('Select simultaneous transfers limit'), findsNothing);
      },
    );
  });

  group('SimultaneousTransfersCard', () {
    testWidgets('renders initial limit and title correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const SimultaneousTransfersCard()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Simultaneous transfers'), findsOneWidget);
      expect(find.text('3 transfers'), findsOneWidget);
    });

    testWidgets('formats single transfer suffix correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SimultaneousTransfersCard(simultaneousTransfers: 1),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Simultaneous transfers'), findsOneWidget);
      expect(find.text('1 transfer'), findsOneWidget);
    });

    testWidgets('tapping card opens sheet and updates limit', (tester) async {
      int? changedLimit;
      var isPressCalled = false;

      await tester.pumpWidget(
        buildTestWidget(
          SimultaneousTransfersCard(
            onPress: () => isPressCalled = true,
            onSimultaneousTransfersChanged: (limit) => changedLimit = limit,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Simultaneous transfers'));
      await tester.pumpAndSettle();

      expect(isPressCalled, isTrue);
      expect(find.text('Select simultaneous transfers limit'), findsOneWidget);

      await tester.tap(find.text('4 transfer(s)'));
      await tester.pumpAndSettle();

      expect(changedLimit, 4);
      expect(find.text('4 transfers'), findsOneWidget);
    });
  });
}
