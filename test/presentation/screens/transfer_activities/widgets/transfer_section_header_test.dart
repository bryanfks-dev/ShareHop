import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfer_section_header.dart';
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
  group('TransferSectionHeader', () {
    testWidgets('renders title without action button when omitted', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const TransferSectionHeader(
            title: 'Active Now',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Active Now'), findsOneWidget);
      expect(find.byType(FButton), findsNothing);
    });

    testWidgets('renders action button and invokes onActionPress', (
      tester,
    ) async {
      var actionTriggered = false;
      await tester.pumpWidget(
        _buildTestWidget(
          TransferSectionHeader(
            title: 'Active Now',
            actionLabel: 'Cancel all',
            isDestructive: true,
            onActionPress: () => actionTriggered = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Active Now'), findsOneWidget);
      expect(find.text('Cancel all'), findsOneWidget);

      await tester.tap(find.text('Cancel all'));
      await tester.pumpAndSettle();
      expect(actionTriggered, isTrue);
    });
  });
}
