import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/completed_transfer_tile.dart';
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
  group('CompletedTransferTile', () {
    testWidgets('renders filename, subtitle, and responds to tap', (
      tester,
    ) async {
      var pressed = false;
      await tester.pumpWidget(
        _buildTestWidget(
          CompletedTransferTile(
            fileName: 'dataset.csv',
            subtitle: 'Local → Cloud · 4.2 MB',
            icon: FLucideIcons.fileSpreadsheet,
            onPress: () => pressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('dataset.csv'), findsOneWidget);
      expect(find.text('Local → Cloud · 4.2 MB'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.fileSpreadsheet), findsOneWidget);
      expect(find.byIcon(FLucideIcons.circleCheck), findsOneWidget);

      await tester.tap(find.byType(CompletedTransferTile));
      await tester.pumpAndSettle();
      expect(pressed, isTrue);
    });

    testWidgets('renders custom status label and status icon', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const CompletedTransferTile(
            fileName: 'broken.zip',
            subtitle: 'Phone → Server · 10 MB',
            icon: FLucideIcons.fileArchive,
            statusLabel: 'Failed',
            statusIcon: FLucideIcons.circleAlert,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('broken.zip'), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.circleAlert), findsOneWidget);
    });
  });
}
