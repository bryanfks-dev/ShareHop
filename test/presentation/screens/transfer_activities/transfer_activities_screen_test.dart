import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/screen.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/active_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/completed_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/queued_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfers_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: child,
    ),
  );
}

void main() {
  group('TransferActivitiesScreen', () {
    testWidgets('renders header and all transfer sections', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const TransferActivitiesScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TransfersHeader), findsOneWidget);
      expect(find.byType(ActiveTransfersSection), findsOneWidget);
      expect(find.byType(QueuedTransfersSection), findsOneWidget);
      expect(find.byType(CompletedTransfersSection), findsOneWidget);
    });
  });
}
