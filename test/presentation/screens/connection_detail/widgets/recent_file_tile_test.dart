import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/recent_file_tile.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

void main() {
  group('RecentFileTile', () {
    testWidgets('renders name, subtitle, and responds to tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _buildTestWidget(
          RecentFileTile(
            name: 'document.pdf',
            subtitle: '1.2 MB · modified today',
            onPress: () => tapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('document.pdf'), findsOneWidget);
      expect(find.text('1.2 MB · modified today'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.chevronRight), findsOneWidget);

      await tester.tap(find.byType(RecentFileTile));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });

    testWidgets('renders without subtitle when not provided', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const RecentFileTile(
            name: 'archive.zip',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('archive.zip'), findsOneWidget);
    });
  });
}
