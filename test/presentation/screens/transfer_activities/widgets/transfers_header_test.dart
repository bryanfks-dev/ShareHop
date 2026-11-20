import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfers_header.dart';
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
  group('TransfersHeader', () {
    testWidgets('renders title, counts, and triggers more action', (
      tester,
    ) async {
      var morePressed = false;
      await tester.pumpWidget(
        _buildTestWidget(
          TransfersHeader(
            activeTransferCount: 2,
            queueTransferCount: 5,
            onMorePress: () => morePressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Transfers'), findsOneWidget);
      expect(find.text('2 active · 5 queued'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.ellipsis), findsOneWidget);

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();
      expect(morePressed, isTrue);
    });
  });
}
