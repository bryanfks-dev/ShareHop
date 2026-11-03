import 'package:flutter/widgets.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/active_transfer_card.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfer_section_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ActiveTransfersSection extends StatelessWidget {
  const new({this.onCancelAllPress, this.onPausePress, super.key});

  final VoidCallback? onCancelAllPress;
  final VoidCallback? onPausePress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: Spacing.sm,
      children: [
        TransferSectionHeader(
          title: 'ACTIVE NOW',
          actionLabel: 'Cancel all',
          isDestructive: true,
          onActionPress: onCancelAllPress,
        ),
        ActiveTransferCard(onPausePress: onPausePress),
      ],
    );
  }
}
