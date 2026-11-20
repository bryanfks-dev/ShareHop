import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfer_activities_more_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  group('TransferActivitiesMoreSheet', () {
    testWidgets(
      'showTransferActivitiesMoreSheet opens sheet and triggers refresh',
      (tester) async {
        var isRefreshCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: const [
              ...FLocalizations.localizationsDelegates,
            ],
            builder: (context, child) => FTheme(
              data: lightTheme,
              child: FToaster(child: child!),
            ),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      unawaited(
                        showTransferActivitiesMoreSheet(
                          context,
                          onPressRefresh: () async {
                            isRefreshCalled = true;
                          },
                          onPressClearAll: () async {},
                        ),
                      );
                    },
                    child: const Text('Open Sheet'),
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Open Sheet'));
        await tester.pumpAndSettle();

        expect(find.text('Transfer Options'), findsOneWidget);
        expect(find.text('Refresh transfers'), findsOneWidget);
        expect(find.text('Clear all history'), findsOneWidget);

        expect(find.byType(FTileGroup), findsOneWidget);

        await tester.tap(find.text('Refresh transfers'));
        await tester.pumpAndSettle();

        expect(isRefreshCalled, isTrue);
        expect(find.text('Transfer Options'), findsNothing);
      },
    );

    testWidgets('tapping Clear all history triggers clear callback', (
      tester,
    ) async {
      var isClearAllCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    unawaited(
                      showTransferActivitiesMoreSheet(
                        context,
                        onPressRefresh: () async {},
                        onPressClearAll: () async {
                          isClearAllCalled = true;
                        },
                      ),
                    );
                  },
                  child: const Text('Open Sheet'),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Clear all history'));
      await tester.pumpAndSettle();

      expect(isClearAllCalled, isTrue);
      expect(find.text('Transfer Options'), findsNothing);
    });
  });
}
