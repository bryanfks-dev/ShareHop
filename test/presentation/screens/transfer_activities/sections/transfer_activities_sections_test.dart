import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/active_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/completed_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/queued_transfers_section.dart';
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
  final activeItem = FileTransferHistoryModel(
    id: const Uuid().v7obj(),
    fileName: 'document.pdf',
    fileSize: 1024 * 500,
    fileMimeType: 'application/pdf',
    sourceName: 'iPhone',
    destinationName: 'NAS',
    status: FileTransferStatus.inProgress,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final queuedItem = FileTransferHistoryModel(
    id: const Uuid().v7obj(),
    fileName: 'image.png',
    fileSize: 1024 * 1024 * 2,
    fileMimeType: 'image/png',
    sourceName: 'iPhone',
    destinationName: 'NAS',
    status: FileTransferStatus.pending,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final completedItem = FileTransferHistoryModel(
    id: const Uuid().v7obj(),
    fileName: 'archive.zip',
    fileSize: 1024 * 1024 * 10,
    fileMimeType: 'application/zip',
    sourceName: 'iPhone',
    destinationName: 'NAS',
    status: FileTransferStatus.completed,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  group('Transfer Activities Sections', () {
    testWidgets('ActiveTransfersSection renders empty and filled states', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const ActiveTransfersSection(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Active Now'), findsOneWidget);
      expect(find.text('No active transfers'), findsOneWidget);

      await tester.pumpWidget(
        _buildTestWidget(
          ActiveTransfersSection(transfers: [activeItem]),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Cancel all'), findsOneWidget);
      expect(find.text('document.pdf'), findsOneWidget);
    });

    testWidgets('QueuedTransfersSection renders empty and filled states', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const QueuedTransfersSection(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Up Next'), findsOneWidget);
      expect(find.text('No queued transfers'), findsOneWidget);

      await tester.pumpWidget(
        _buildTestWidget(
          QueuedTransfersSection(transfers: [queuedItem]),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('image.png'), findsOneWidget);
      expect(find.text('Waiting'), findsOneWidget);
    });

    testWidgets('CompletedTransfersSection renders empty and filled states', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const CompletedTransfersSection(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Completed Today'), findsOneWidget);
      expect(find.text('No completed transfers'), findsOneWidget);

      await tester.pumpWidget(
        _buildTestWidget(
          CompletedTransfersSection(transfers: [completedItem]),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Clear all'), findsOneWidget);
      expect(find.text('archive.zip'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
    });
  });
}
