import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/core/repositories/file_transfer_history_repository.dart';
import 'package:sharehop/di/file_transfer_history_di.dart';
import 'package:sharehop/presentation/controllers/file_transfer_history_controller.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/screen.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/active_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/completed_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/queued_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/active_transfer_card.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/completed_transfer_tile.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/connection_filter_dropdown.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/queued_transfer_tile.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfers_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:uuid/uuid.dart';

class _FakeFileTransferHistoryRepository
    implements FileTransferHistoryRepository {
  new({List<FileTransferHistoryModel>? initial}) : items = initial ?? [];

  final List<FileTransferHistoryModel> items;

  @override
  Future<List<FileTransferHistoryModel>> getAll({
    FileTransferStatus? status,
    String? searchQuery,
  }) async {
    return items.where((item) {
      if (status != null && item.status != status) return false;
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        if (!item.fileName.toLowerCase().contains(q) &&
            !item.sourceName.toLowerCase().contains(q) &&
            !item.destinationName.toLowerCase().contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  @override
  Future<FileTransferHistoryModel?> getById(UuidValue id) async {
    return items.where((e) => e.id == id).firstOrNull;
  }

  @override
  Future<void> insert(FileTransferHistoryModel history) async {
    items.add(history);
  }

  @override
  Future<void> update(FileTransferHistoryModel history) async {
    final idx = items.indexWhere((e) => e.id == history.id);
    if (idx != -1) items[idx] = history;
  }

  @override
  Future<void> delete(UuidValue id) async {
    items.removeWhere((e) => e.id == id);
  }

  @override
  Future<void> clearAll() async {
    items.clear();
  }
}

Widget _buildTestWidget(
  Widget child, {
  _FakeFileTransferHistoryRepository? repository,
}) {
  return ProviderScope(
    overrides: [
      if (repository != null)
        fileTransferHistoryRepositoryProvider.overrideWithValue(repository),
    ],
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
    testWidgets('renders header, filter dropdown, and all transfer sections', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(const TransferActivitiesScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TransfersHeader), findsOneWidget);
      expect(find.byType(ConnectionFilterDropdown), findsOneWidget);
      expect(find.byType(ActiveTransfersSection), findsOneWidget);
      expect(find.byType(QueuedTransfersSection), findsOneWidget);
      expect(find.byType(CompletedTransfersSection), findsOneWidget);
    });

    testWidgets('shows empty state messages when repository has no transfers', (
      tester,
    ) async {
      final fakeRepo = _FakeFileTransferHistoryRepository(initial: []);

      await tester.pumpWidget(
        _buildTestWidget(
          const TransferActivitiesScreen(),
          repository: fakeRepo,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No active transfers'), findsOneWidget);
      expect(find.text('No queued transfers'), findsOneWidget);
      expect(find.text('No completed transfers'), findsOneWidget);
      expect(find.text('0 active · 0 queued'), findsOneWidget);
    });

    testWidgets('displays real active, queued, and completed transfers', (
      tester,
    ) async {
      final now = DateTime.now();
      final active = FileTransferHistoryModel(
        id: const Uuid().v4obj(),
        fileName: 'live_stream.mp4',
        fileSize: 10485760,
        fileMimeType: 'video/mp4',
        sourceName: 'iPhone',
        destinationName: 'Main Server',
        status: FileTransferStatus.inProgress,
        createdAt: now,
        updatedAt: now,
      );
      final queued = FileTransferHistoryModel(
        id: const Uuid().v4obj(),
        fileName: 'archive.zip',
        fileSize: 5242880,
        fileMimeType: 'application/zip',
        sourceName: 'Local Storage',
        destinationName: 'Cloud Drive',
        status: FileTransferStatus.pending,
        createdAt: now,
        updatedAt: now,
      );
      final completed = FileTransferHistoryModel(
        id: const Uuid().v4obj(),
        fileName: 'report.pdf',
        fileSize: 1048576,
        fileMimeType: 'application/pdf',
        sourceName: 'Cloud Drive',
        destinationName: 'Local Storage',
        status: FileTransferStatus.completed,
        createdAt: now,
        updatedAt: now,
      );

      final fakeRepo = _FakeFileTransferHistoryRepository(
        initial: [active, queued, completed],
      );

      await tester.pumpWidget(
        _buildTestWidget(
          const TransferActivitiesScreen(),
          repository: fakeRepo,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1 active · 1 queued'), findsOneWidget);
      expect(find.text('live_stream.mp4'), findsOneWidget);
      expect(find.text('archive.zip'), findsOneWidget);
      expect(find.text('report.pdf'), findsOneWidget);
      expect(find.byType(ActiveTransferCard), findsOneWidget);
      expect(find.byType(QueuedTransferTile), findsOneWidget);
      expect(find.byType(CompletedTransferTile), findsOneWidget);
    });

    testWidgets('filters transfers when connection filter is set', (
      tester,
    ) async {
      final now = DateTime.now();
      final active = FileTransferHistoryModel(
        id: const Uuid().v4obj(),
        fileName: 'video.mp4',
        fileSize: 10485760,
        fileMimeType: 'video/mp4',
        sourceName: 'iPhone',
        destinationName: 'Server Alpha',
        status: FileTransferStatus.inProgress,
        createdAt: now,
        updatedAt: now,
      );
      final queued = FileTransferHistoryModel(
        id: const Uuid().v4obj(),
        fileName: 'document.pdf',
        fileSize: 2048576,
        fileMimeType: 'application/pdf',
        sourceName: 'Server Beta',
        destinationName: 'Downloads',
        status: FileTransferStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      final fakeRepo = _FakeFileTransferHistoryRepository(
        initial: [active, queued],
      );

      late WidgetRef capturedRef;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            fileTransferHistoryRepositoryProvider.overrideWithValue(fakeRepo),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              ...FLocalizations.localizationsDelegates,
            ],
            builder: (context, c) => FTheme(
              data: lightTheme,
              child: FToaster(
                child: Consumer(
                  builder: (context, ref, _) {
                    capturedRef = ref;
                    return c!;
                  },
                ),
              ),
            ),
            home: const TransferActivitiesScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('video.mp4'), findsOneWidget);
      expect(find.text('document.pdf'), findsOneWidget);

      await capturedRef
          .read(fileTransferHistoryControllerProvider.notifier)
          .filterByConnection('Server Alpha');
      await tester.pumpAndSettle();

      expect(find.text('video.mp4'), findsOneWidget);
      expect(find.text('document.pdf'), findsNothing);
      expect(find.text('1 active · 0 queued'), findsOneWidget);
      expect(find.text('No queued transfers'), findsOneWidget);
    });

    testWidgets('tapping header more button opens transfer options sheet', (
      tester,
    ) async {
      final fakeRepo = _FakeFileTransferHistoryRepository(initial: []);

      await tester.pumpWidget(
        _buildTestWidget(
          const TransferActivitiesScreen(),
          repository: fakeRepo,
        ),
      );
      await tester.pumpAndSettle();

      final moreButton = find.byIcon(FLucideIcons.ellipsis);
      expect(moreButton, findsOneWidget);

      await tester.tap(moreButton);
      await tester.pumpAndSettle();

      expect(find.text('Transfer Options'), findsOneWidget);
      expect(find.text('Refresh transfers'), findsOneWidget);
      expect(find.text('Clear all history'), findsOneWidget);

      await tester.tap(find.text('Refresh transfers'));
      await tester.pumpAndSettle();

      expect(find.text('Transfer Options'), findsNothing);
    });
  });
}
