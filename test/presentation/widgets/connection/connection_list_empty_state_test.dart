import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/connection_list_empty_state.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(body: child),
  );
}

void main() {
  group('ConnectionListEmptyState', () {
    testWidgets(
      'renders empty state tile group with message, icon, and action'
      ' description',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(const ConnectionListEmptyState()),
        );

        expect(find.byType(FTileGroup), findsOneWidget);
        expect(find.byType(FTile), findsOneWidget);
        expect(find.byIcon(FLucideIcons.pinOff), findsOneWidget);
        expect(find.text('No pinned connections'), findsOneWidget);
        expect(
          find.text(
            'Tap Manage to pin your favorite connections for quick access '
            'here.',
          ),
          findsOneWidget,
        );
      },
    );
  });
}
