import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/presentation/controllers/file_transfer_history_controller.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/active_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/completed_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/queued_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/connection_filter_dropdown.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfer_activities_more_sheet.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfers_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class TransferActivitiesScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final historyState = ref.watch(fileTransferHistoryControllerProvider);
    final historyController = ref.watch(
      fileTransferHistoryControllerProvider.notifier,
    );
    final connectionsState = ref.watch(
      managePinnedConnectionsControllerProvider,
    );

    final connectionNames = <String>{
      ...connectionsState.pinnedConnections.map((c) => c.displayName),
      ...connectionsState.otherConnections.map((c) => c.displayName),
      for (final h in historyState.histories) ...[
        if (h.sourceName.isNotEmpty) h.sourceName,
        if (h.destinationName.isNotEmpty) h.destinationName,
      ],
    }.toList()..sort();

    final transfers = historyState.filteredHistories;
    final activeTransfers = transfers
        .where((t) => t.status == FileTransferStatus.inProgress)
        .toList();
    final queuedTransfers = transfers
        .where((t) => t.status == FileTransferStatus.pending)
        .toList();
    final completedTransfers = transfers
        .where(
          (t) =>
              t.status == FileTransferStatus.completed ||
              t.status == FileTransferStatus.failed ||
              t.status == FileTransferStatus.canceled,
        )
        .toList();

    void handleOnChangeConnection(String? connection) {
      unawaited(historyController.filterByConnection(connection));
    }

    void handleOnCancelAllActive() {
      unawaited(
        historyController.cancelAllActive(
          connection: historyState.selectedConnection,
        ),
      );
    }

    void handleOnItemCancelActive(FileTransferHistoryModel transfer) {
      unawaited(historyController.cancelTransfer(transfer.id));
    }

    void handleOnCancelAllQueued() {
      unawaited(
        historyController.cancelAllQueued(
          connection: historyState.selectedConnection,
        ),
      );
    }

    void handleOnClearCompleted() {
      unawaited(
        historyController.clearCompleted(
          connection: historyState.selectedConnection,
        ),
      );
    }

    Future<void> handleOnPressClearAll() async {
      await historyController.clearHistory();
    }

    Future<void> handleOnPressRefresh() async {
      await historyController.refresh();
    }

    void handleOnPressMore() {
      unawaited(
        showTransferActivitiesMoreSheet(
          context,
          onPressClearAll: handleOnPressClearAll,
          onPressRefresh: handleOnPressRefresh,
        ),
      );
    }

    return FScaffold(
      header: TransfersHeader(
        activeTransferCount: activeTransfers.length,
        queueTransferCount: queuedTransfers.length,
        onMorePress: handleOnPressMore,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
          child: Column(
            crossAxisAlignment: .start,
            spacing: Spacing.xl,
            mainAxisSize: .min,
            children: [
              ConnectionFilterDropdown(
                connections: connectionNames,
                selectedConnection: historyState.selectedConnection,
                onChangeConnection: handleOnChangeConnection,
              ),
              ActiveTransfersSection(
                transfers: activeTransfers,
                onCancelAllPress: handleOnCancelAllActive,
                onItemCancelPress: handleOnItemCancelActive,
              ),
              QueuedTransfersSection(
                transfers: queuedTransfers,
                onCancelAllPress: handleOnCancelAllQueued,
              ),
              CompletedTransfersSection(
                transfers: completedTransfers,
                onActionPress: handleOnClearCompleted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
