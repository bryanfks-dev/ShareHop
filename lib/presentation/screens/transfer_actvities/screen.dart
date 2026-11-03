import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/active_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/completed_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/sections/queued_transfers_section.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/transfers_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class TransferActivitiesScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      header: const TransfersHeader(),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
          child: const Column(
            crossAxisAlignment: .start,
            spacing: Spacing.xl,
            mainAxisSize: .min,
            children: [
              ActiveTransfersSection(),
              QueuedTransfersSection(),
              CompletedTransfersSection(),
            ],
          ),
        ),
      ),
    );
  }
}
