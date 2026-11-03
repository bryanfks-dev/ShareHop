import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/quick_action_card.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class QuickActionsSection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressBrowseFiles() {}
    void handleOnPressTransferFiles() {}

    return Column(
      spacing: Spacing.lg,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Text(
          'QUICK ACTIONS',
          style: theme.typography.display.xs.copyWith(
            color: theme.colors.foreground,
            fontWeight: .w700,
          ),
        ),
        Row(
          spacing: Spacing.md,
          children: [
            Expanded(
              child: QuickActionCard(
                title: 'Browse files',
                subtitle: 'Open remote folders',
                icon: FLucideIcons.folder,
                variant: QuickActionCardVariant.primary,
                onPress: handleOnPressBrowseFiles,
              ),
            ),
            Expanded(
              child: QuickActionCard(
                title: 'Transfer files',
                subtitle: 'Send or receive',
                icon: FLucideIcons.arrowUpDown,
                onPress: handleOnPressTransferFiles,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
