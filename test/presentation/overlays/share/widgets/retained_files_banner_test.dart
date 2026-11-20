import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/retained_files_banner.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('RetainedFilesBanner', () {
    testWidgets('renders banner text with provided file count', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const RetainedFilesBanner(fileCount: 5)),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(
          'These 5 file(s) will be retained while '
          'you set up the new connection.',
        ),
        findsOneWidget,
      );
    });
  });
}
