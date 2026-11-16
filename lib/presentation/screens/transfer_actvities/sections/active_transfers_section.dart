import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/active_transfer_card.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfer_section_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/primitives/empty_state.dart';

class ActiveTransfersSection extends StatelessWidget {
  const new({
    this.transfers = const [],
    this.onCancelAllPress,
    this.onPausePress,
    this.onItemCancelPress,
    super.key,
  });

  final List<FileTransferHistoryModel> transfers;
  final VoidCallback? onCancelAllPress;
  final VoidCallback? onPausePress;
  final void Function(FileTransferHistoryModel transfer)? onItemCancelPress;

  @override
  Widget build(BuildContext context) {
    void handleOnPressPause(FileTransferHistoryModel transfer) {
      if (onItemCancelPress != null) {
        onItemCancelPress!(transfer);
      } else {
        onPausePress?.call();
      }
    }

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: Spacing.sm,
      children: [
        TransferSectionHeader(
          title: 'Active Now',
          actionLabel: transfers.isNotEmpty ? 'Cancel all' : null,
          isDestructive: true,
          onActionPress: onCancelAllPress,
        ),
        Builder(
          builder: (context) {
            if (transfers.isEmpty) {
              return EmptyState.card(
                icon: FLucideIcons.arrowUpDown,
                title: 'No active transfers',
                description:
                    'Start a file transfer from any connection to monitor '
                    'live progress.',
              );
            }

            return Column(
              mainAxisSize: .min,
              spacing: Spacing.sm,
              children: [
                for (final transfer in transfers)
                  ActiveTransferCard(
                    transfer: transfer,
                    onPausePress: () => handleOnPressPause(transfer),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
