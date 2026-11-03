import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/queued_transfer_tile.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfer_section_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class QueuedTransfersSection extends StatelessWidget {
  const new({this.onCancelAllPress, super.key});

  final VoidCallback? onCancelAllPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: Spacing.sm,
      children: [
        TransferSectionHeader(
          title: 'UP NEXT',
          actionLabel: 'Cancel all',
          isDestructive: true,
          onActionPress: onCancelAllPress,
        ),
        FTileGroup(
          style: .delta(decoration: .shapeDelta(color: theme.colors.card)),
          divider: .full,
          children: const [
            QueuedTransferTile(
              fileName: 'release-build-2.4.1.zip',
              subtitle: 'On My iPhone → Production · 82.4 MB',
            ),
            QueuedTransferTile(
              fileName: 'press-kit-assets.zip',
              subtitle: 'Studio NAS → Cloud archive · 146.8 MB',
            ),
          ],
        ),
      ],
    );
  }
}
