import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/active_transfer_card.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:uuid/uuid.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(
      body: SingleChildScrollView(child: child),
    ),
  );
}

void main() {
  group('ActiveTransferCard', () {
    testWidgets('renders fallback transfer card when transfer is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const ActiveTransferCard(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('product-demo-final.mp4'), findsOneWidget);
      expect(
        find.text('On My iPhone → Production / releases'),
        findsOneWidget,
      );
      expect(find.text('Encrypted SFTP'), findsOneWidget);
    });

    testWidgets('renders transfer model details and handles pause', (
      tester,
    ) async {
      var paused = false;
      final model = FileTransferHistoryModel(
        id: const Uuid().v7obj(),
        fileName: 'presentation.key',
        fileSize: 1024 * 1024 * 12,
        fileMimeType: 'application/x-iwork-keynote-sffkey',
        sourceName: 'My iPad',
        destinationName: 'Office NAS',
        status: FileTransferStatus.inProgress,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        _buildTestWidget(
          ActiveTransferCard(
            transfer: model,
            onPausePress: () => paused = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('presentation.key'), findsOneWidget);
      expect(find.text('My iPad → Office NAS'), findsOneWidget);
      expect(find.text('Encrypted Transfer'), findsOneWidget);

      final pauseBtn = find.byType(FButton);
      expect(pauseBtn, findsWidgets);
      await tester.tap(pauseBtn.first);
      await tester.pumpAndSettle();
      expect(paused, isTrue);
    });
  });
}
