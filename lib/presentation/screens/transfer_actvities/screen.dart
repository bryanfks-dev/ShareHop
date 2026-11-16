import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/presentation/controllers/file_transfer_history_controller.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/active_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/completed_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/queued_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/connection_filter_dropdown.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfers_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showTransferActivitiesMoreSheet({
  required BuildContext context,
  required Future<void> Function() onPressClearAll,
  required Future<void> Function() onPressRefresh,
}) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) => _TransferActivitiesMoreSheet(
      onPressClearAll: onPressClearAll,
      onPressRefresh: onPressRefresh,
    ),
  );
}

class TransferActivitiesScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final historyState = ref.watch(fileTransferHistoryControllerProvider);
    final historyController =
        ref.watch(fileTransferHistoryControllerProvider.notifier);
    final connectionsState =
        ref.watch(managePinnedConnectionsControllerProvider);

    final connectionNames = <String>{
      ...connectionsState.pinnedConnections.map((c) => c.displayName),
      ...connectionsState.otherConnections.map((c) => c.displayName),
      for (final h in historyState.histories) ...[
        if (h.sourceName.isNotEmpty) h.sourceName,
        if (h.destinationName.isNotEmpty) h.destinationName,
      ],
    }.toList()..sort();

    final transfers = historyState.filteredHistories;
    final activeTransfers =
        transfers
            .where((t) => t.status == FileTransferStatus.inProgress)
            .toList();
    final queuedTransfers =
        transfers
            .where((t) => t.status == FileTransferStatus.pending)
            .toList();
    final completedTransfers =
        transfers
            .where(
              (t) =>
                  t.status == FileTransferStatus.completed ||
                  t.status == FileTransferStatus.failed ||
                  t.status == FileTransferStatus.canceled,
            )
            .toList();

    final subtitle =
        '${activeTransfers.length} active · ${queuedTransfers.length} queued';

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
          context: context,
          onPressClearAll: handleOnPressClearAll,
          onPressRefresh: handleOnPressRefresh,
        ),
      );
    }

    return FScaffold(
      header: TransfersHeader(
        subtitle: subtitle,
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

class _TransferActivitiesMoreSheet extends StatelessWidget {
  const new({required this.onPressClearAll, required this.onPressRefresh});

  final Future<void> Function() onPressClearAll;
  final Future<void> Function() onPressRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressRefresh() {
      context.navigator.pop();
      unawaited(onPressRefresh());
    }

    void handleOnPressClearAll() {
      context.navigator.pop();
      unawaited(onPressClearAll());
    }

    return Container(
      width: double.maxFinite,
      padding: .symmetric(
        vertical: 2 * theme.style.pagePadding.top,
        horizontal: theme.style.pagePadding.left,
      ),
      decoration: BoxDecoration(
        color: theme.colors.card,
        border: .all(color: theme.colors.border),
        borderRadius: theme.style.borderRadius.xl,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: Spacing.md,
          children: [
            Text(
              'Transfer Options',
              style: theme.typography.display.sm.copyWith(
                color: theme.colors.foreground,
                fontWeight: .w600,
              ),
            ),
            FTileGroup(
              children: [
                FTile(
                  prefix: const Icon(FLucideIcons.refreshCw),
                  title: Text(
                    'Refresh transfers',
                    style: theme.typography.body.sm.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                  onPress: handleOnPressRefresh,
                ),
                FTile(
                  prefix: Icon(
                    FLucideIcons.trash2,
                    color: theme.colors.destructive,
                  ),
                  title: Text(
                    'Clear all history',
                    style: theme.typography.body.sm.copyWith(
                      color: theme.colors.destructive,
                    ),
                  ),
                  onPress: handleOnPressClearAll,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
