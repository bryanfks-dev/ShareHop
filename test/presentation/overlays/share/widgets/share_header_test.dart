import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/share_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('ShareHeader', () {
    testWidgets('renders title and formatted file count & total size', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ShareHeader(fileCount: 4, totalSize: '12.5 MB'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Transfer with ShareHop'), findsOneWidget);
      expect(find.text('4 file(s) selected (12.5 MB)'), findsOneWidget);
    });
  });
}
