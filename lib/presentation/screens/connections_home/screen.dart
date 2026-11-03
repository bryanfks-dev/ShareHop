import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/new_connection_shortcut_section.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/pinned_connections_section.dart';
import 'package:sharehop/presentation/screens/connections_home/sections/quick_connect_section.dart';
import 'package:sharehop/presentation/screens/connections_home/widgets/connections_home_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ConnectionsHomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      header: const ConnectionsHomeHeader(),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
          child: const Column(
            spacing: Spacing.xl,
            mainAxisSize: .min,
            children: [
              QuickConnectSection(),
              PinnedConnectionsSection(),
              NewConnectionShortcutSection(),
            ],
          ),
        ),
      ),
    );
  }
}
