import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/quick_action_card.dart';
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
  group('QuickActionCard', () {
    testWidgets('renders title, subtitle, and icon in subtle variant', (
      tester,
    ) async {
      var pressed = false;
      await tester.pumpWidget(
        _buildTestWidget(
          QuickActionCard(
            title: 'Transfer files',
            subtitle: 'Send or receive',
            icon: FLucideIcons.arrowUpDown,
            onPress: () => pressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Transfer files'), findsOneWidget);
      expect(find.text('Send or receive'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.arrowUpDown), findsOneWidget);

      await tester.tap(find.byType(QuickActionCard));
      await tester.pumpAndSettle();
      expect(pressed, isTrue);
    });

    testWidgets('renders properly with primary variant', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const QuickActionCard(
            title: 'Browse files',
            subtitle: 'Open remote folders',
            icon: FLucideIcons.folder,
            variant: QuickActionCardVariant.primary,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Browse files'), findsOneWidget);
      expect(find.text('Open remote folders'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.folder), findsOneWidget);
    });
  });
}
