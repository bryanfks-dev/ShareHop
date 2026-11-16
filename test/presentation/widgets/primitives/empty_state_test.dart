import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/primitives/empty_state.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('EmptyState', () {
    testWidgets('renders icon, title, and action description', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const EmptyState(
            icon: FLucideIcons.hardDrive,
            title: 'No files found',
            description: 'Upload files to see them listed here.',
          ),
        ),
      );

      expect(find.byIcon(FLucideIcons.hardDrive), findsOneWidget);
      expect(find.text('No files found'), findsOneWidget);
      expect(
        find.text('Upload files to see them listed here.'),
        findsOneWidget,
      );
    });

    testWidgets('renders optional action widget when provided', (tester) async {
      var actionTapped = false;

      await tester.pumpWidget(
        _buildTestWidget(
          EmptyState(
            icon: FLucideIcons.hardDrive,
            title: 'No files found',
            description: 'Upload files to see them listed here.',
            action: FButton(
              onPress: () => actionTapped = true,
              child: const Text('Upload'),
            ),
          ),
        ),
      );

      expect(find.text('Upload'), findsOneWidget);
      await tester.tap(find.text('Upload'));
      await tester.pumpAndSettle();
      expect(actionTapped, isTrue);
    });

    testWidgets('EmptyState.card wraps content in FTileGroup and FTile', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          EmptyState.card(
            icon: FLucideIcons.pinOff,
            title: 'No pinned connections',
            description: 'Pin connections for quick access.',
          ),
        ),
      );

      expect(find.byType(FTileGroup), findsOneWidget);
      expect(find.byType(FTile), findsOneWidget);
      expect(find.byIcon(FLucideIcons.pinOff), findsOneWidget);
      expect(find.text('No pinned connections'), findsOneWidget);
      expect(find.text('Pin connections for quick access.'), findsOneWidget);
    });
  });
}
