import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/queued_transfer_tile.dart';
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
  group('QueuedTransferTile', () {
    testWidgets('renders filename, subtitle, and waiting badge', (
      tester,
    ) async {
      var pressed = false;
      await tester.pumpWidget(
        _buildTestWidget(
          QueuedTransferTile(
            fileName: 'archive.tar.gz',
            subtitle: 'Phone → Server · 1.4 GB',
            onPress: () => pressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('archive.tar.gz'), findsOneWidget);
      expect(find.text('Phone → Server · 1.4 GB'), findsOneWidget);
      expect(find.text('Waiting'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.clock), findsOneWidget);

      await tester.tap(find.byType(QueuedTransferTile));
      await tester.pumpAndSettle();
      expect(pressed, isTrue);
    });
  });
}
