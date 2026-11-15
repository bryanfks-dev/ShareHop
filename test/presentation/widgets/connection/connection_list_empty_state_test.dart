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
    testWidgets('renders empty state messages and icon', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const ConnectionListEmptyState()),
      );

      expect(find.text('No pinned connections'), findsOneWidget);
      expect(
        find.text('You can pin your favorite connections here.'),
        findsOneWidget,
      );
      expect(find.byIcon(FLucideIcons.link2Off), findsOneWidget);
    });
  });
}
