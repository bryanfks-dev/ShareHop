import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/presentation/extensions/enums/file_transfer_status_extension.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/completed_transfer_tile.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfer_section_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/utils/file_icon_resolver.dart';
import 'package:sharehop/presentation/utils/file_size_formatter.dart';
import 'package:sharehop/presentation/widgets/primitives/empty_state.dart';

class CompletedTransfersSection extends StatelessWidget {
  const new({
    this.transfers = const [],
    this.actionLabel,
    this.onActionPress,
    this.onViewHistoryPress,
    this.onItemPress,
    super.key,
  });

  final List<FileTransferHistoryModel> transfers;
  final String? actionLabel;
  final VoidCallback? onActionPress;
  final VoidCallback? onViewHistoryPress;
  final void Function(FileTransferHistoryModel transfer)? onItemPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final effectiveActionLabel = transfers.isNotEmpty
        ? (actionLabel ??
              (onViewHistoryPress != null ? 'View history' : 'Clear all'))
        : null;
    final effectiveOnActionPress = onActionPress ?? onViewHistoryPress;

    VoidCallback? createHandleOnPressItem(FileTransferHistoryModel item) {
      if (onItemPress == null) {
        return null;
      }
      return () => onItemPress!(item);
    }

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: Spacing.sm,
      children: [
        TransferSectionHeader(
          title: 'Completed Today',
          actionLabel: effectiveActionLabel,
          onActionPress: effectiveOnActionPress,
        ),
        FTileGroup(
          style: .delta(decoration: .shapeDelta(color: theme.colors.card)),
          divider: .full,
          children: transfers.isEmpty
              ? [
                  FTile(
                    title: const EmptyState(
                      icon: FLucideIcons.circleCheck,
                      title: 'No completed transfers',
                      description:
                          'Transfers finished today will appear here '
                          'for your records.',
                    ),
                  ),
                ]
              : [
                  for (final item in transfers)
                    CompletedTransferTile(
                      fileName: item.fileName,
                      subtitle:
                          '${item.sourceName} → ${item.destinationName} · '
                          '${formatFileSize(bytes: item.fileSize)}',
                      icon: item.fileName.fileIcon,
                      statusLabel: switch (item.status) {
                        FileTransferStatus.completed => 'Completed',
                        FileTransferStatus.failed => 'Failed',
                        FileTransferStatus.canceled => 'Canceled',
                        _ => item.status.label,
                      },
                      statusIcon: switch (item.status) {
                        FileTransferStatus.completed =>
                          FLucideIcons.circleCheck,
                        FileTransferStatus.failed => FLucideIcons.circleAlert,
                        FileTransferStatus.canceled => FLucideIcons.circleSlash,
                        _ => FLucideIcons.circleCheck,
                      },
                      statusColor: switch (item.status) {
                        FileTransferStatus.completed =>
                          theme.colors.app.success,
                        FileTransferStatus.failed => theme.colors.destructive,
                        FileTransferStatus.canceled =>
                          theme.colors.mutedForeground,
                        _ => theme.colors.app.success,
                      },
                      onPress: createHandleOnPressItem(item),
                    ),
                ],
        ),
      ],
    );
  }
}
