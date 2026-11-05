import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/sections/other_connections_manage_section.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/sections/pinned_connections_manage_section.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_pinned_callout_banner.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_pinned_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ManagePinnedConnectionsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressDone() {
      context.navigator.pop();
    }

    return FScaffold(
      header: ManagePinnedHeader(onPressDone: handleOnPressDone),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
          child: const Column(
            crossAxisAlignment: .start,
            spacing: Spacing.xl,
            children: [
              ManagePinnedCalloutBanner(),
              PinnedConnectionsManageSection(),
              OtherConnectionsManageSection(),
            ],
          ),
        ),
      ),
    );
  }
}
