import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_empty_state.dart';
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

  group('SelectedFilesEmptyState', () {
    testWidgets('renders empty state text and restore button when excluded', (
      tester,
    ) async {
      var isRestoreCalled = false;

      await tester.pumpWidget(
        buildTestWidget(
          SelectedFilesEmptyState(
            hasExcludedFiles: true,
            onRestoreAll: () => isRestoreCalled = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No files selected'), findsOneWidget);
      expect(find.text('All files have been excluded.'), findsOneWidget);
      expect(find.text('Restore all files'), findsOneWidget);

      await tester.tap(find.text('Restore all files'));
      await tester.pumpAndSettle();

      expect(isRestoreCalled, isTrue);
    });

    testWidgets(
      'does not render restore button when hasExcludedFiles is false',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const SelectedFilesEmptyState(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('No files selected'), findsOneWidget);
        expect(find.text('Restore all files'), findsNothing);
      },
    );
  });
}
