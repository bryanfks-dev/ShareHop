import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/queued_transfer_tile.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfer_section_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/utils/file_icon_resolver.dart';
import 'package:sharehop/presentation/utils/file_size_formatter.dart';
import 'package:sharehop/presentation/widgets/primitives/empty_state.dart';

class QueuedTransfersSection extends StatelessWidget {
  const new({
    this.transfers = const [],
    this.onCancelAllPress,
    this.onItemPress,
    super.key,
  });

  final List<FileTransferHistoryModel> transfers;
  final VoidCallback? onCancelAllPress;
  final void Function(FileTransferHistoryModel transfer)? onItemPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

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
          title: 'Up Next',
          actionLabel: transfers.isNotEmpty ? 'Cancel all' : null,
          isDestructive: true,
          onActionPress: onCancelAllPress,
        ),
        FTileGroup(
          style: .delta(decoration: .shapeDelta(color: theme.colors.card)),
          divider: .full,
          children: transfers.isEmpty
              ? [
                  FTile(
                    title: const EmptyState(
                      icon: FLucideIcons.clock,
                      title: 'No queued transfers',
                      description:
                          'Queue multiple files to transfer sequentially '
                          'based on your settings.',
                    ),
                  ),
                ]
              : [
                  for (final item in transfers)
                    QueuedTransferTile(
                      fileName: item.fileName,
                      subtitle:
                          '${item.sourceName} → ${item.destinationName} · '
                          '${formatFileSize(bytes: item.fileSize)}',
                      icon: item.fileName.fileIcon,
                      onPress: createHandleOnPressItem(item),
                    ),
                ],
        ),
      ],
    );
  }
}
