import 'package:flutter/material.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/scaffold.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/connection_identity_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/landscape_workspace_path_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/quick_actions_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/recent_folders_and_files_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/storage_usage_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_detail_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ConnectionDetailScreen extends StatelessWidget {
  const new({required this.connection, super.key});

  final ConnectionModel connection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      header: ConnectionDetailHeader(connection: connection),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
          child: Column(
            crossAxisAlignment: .start,
            spacing: Spacing.lg,
            mainAxisSize: .min,
            children: [
              ConnectionIdentitySection(connection: connection),
              StorageUsageSection(connection: connection),
              const QuickActionsSection(),
              const RecentFoldersAndFilesSection(),
              LandscapeWorkspacePathSection(connection: connection),
            ],
          ),
        ),
      ),
    );
  }
}
