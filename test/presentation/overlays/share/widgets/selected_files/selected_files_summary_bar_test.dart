import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_summary_bar.dart';
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

  group('SelectedFilesSummaryBar', () {
    testWidgets('renders active count and actions correctly', (tester) async {
      var isExcludeAllCalled = false;
      var isIncludeAllCalled = false;

      await tester.pumpWidget(
        buildTestWidget(
          SelectedFilesSummaryBar(
            activeCount: 3,
            activeFormattedSize: '15.0 MB',
            excludedCount: 2,
            onExcludeAll: () => isExcludeAllCalled = true,
            onIncludeAll: () => isIncludeAllCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('3 ready (15.0 MB)'), findsOneWidget);
      expect(find.text('Exclude all'), findsOneWidget);
      expect(find.text('Include all'), findsOneWidget);

      await tester.tap(find.text('Exclude all'));
      await tester.pumpAndSettle();
      expect(isExcludeAllCalled, isTrue);

      await tester.tap(find.text('Include all'));
      await tester.pumpAndSettle();
      expect(isIncludeAllCalled, isTrue);
    });

    testWidgets('renders empty state text when activeCount is 0', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SelectedFilesSummaryBar(
            activeCount: 0,
            activeFormattedSize: '0 B',
            excludedCount: 3,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('0 files ready to transfer'), findsOneWidget);
    });
  });
}
