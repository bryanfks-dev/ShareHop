import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/recent_folder_tile.dart';
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
  group('RecentFolderTile', () {
    testWidgets('renders folder name, subtitle, and responds to tap', (
      tester,
    ) async {
      var tapped = false;
      await tester.pumpWidget(
        _buildTestWidget(
          RecentFolderTile(
            name: 'photos',
            subtitle: '15 items',
            onPress: () => tapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('photos'), findsOneWidget);
      expect(find.text('15 items'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.folder), findsOneWidget);
      expect(find.byIcon(FLucideIcons.chevronRight), findsOneWidget);

      await tester.tap(find.byType(RecentFolderTile));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });

    testWidgets('renders without subtitle when not provided', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const RecentFolderTile(
            name: 'documents',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('documents'), findsOneWidget);
    });
  });
}
