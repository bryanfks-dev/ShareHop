import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_sheet_header.dart';
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

  group('SelectedFilesSheetHeader', () {
    testWidgets('renders title and selected file count', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const SelectedFilesSheetHeader(fileCount: 7)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Selected Files'), findsOneWidget);
      expect(find.text('7 file(s) selected'), findsOneWidget);
    });
  });
}
