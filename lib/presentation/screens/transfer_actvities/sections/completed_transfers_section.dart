import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/completed_transfer_tile.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfer_section_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class CompletedTransfersSection extends StatelessWidget {
  const new({this.onViewHistoryPress, super.key});

  final VoidCallback? onViewHistoryPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: Spacing.sm,
      children: [
        TransferSectionHeader(
          title: 'COMPLETED TODAY',
          actionLabel: 'View history',
          onActionPress: onViewHistoryPress,
        ),
        FTileGroup(
          style: .delta(decoration: .shapeDelta(color: theme.colors.card)),
          divider: .full,
          children: [
            CompletedTransferTile(
              fileName: 'launch-hero@2x.png',
              subtitle: 'Production → Downloads · 8.4 MB',
              icon: FLucideIcons.image,
              iconColor: theme.colors.app.accentBlue,
              iconBackgroundColor: theme.colors.secondary,
            ),
            const CompletedTransferTile(
              fileName: 'brand-guidelines-v6.pdf',
              subtitle: 'WebDAV → Files · 12.1 MB',
              icon: FLucideIcons.fileText,
            ),
          ],
        ),
      ],
    );
  }
}
