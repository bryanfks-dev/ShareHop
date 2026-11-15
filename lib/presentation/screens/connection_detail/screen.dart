import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/connection_identity_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/landscape_workspace_path_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/quick_actions_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/recent_folders_and_files_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/storage_usage_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_detail_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class ConnectionDetailScreen extends ConsumerStatefulWidget {
  const new({
    required this.connection,
    this.controller,
    this.onEdit,
    this.onDelete,
    this.onCheckConnection,
    super.key,
  });

  final ConnectionViewModel connection;
  final FPopoverController? controller;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onCheckConnection;

  @override
  ConsumerState<ConnectionDetailScreen> createState() =>
      _ConnectionDetailScreenState();
}

class _ConnectionDetailScreenState
    extends ConsumerState<ConnectionDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await _checkStatus();
      }
    });
  }

  @override
  void didUpdateWidget(covariant ConnectionDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.connection.id != widget.connection.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (mounted) {
          await _checkStatus();
        }
      });
    }
  }

  Future<void> _checkStatus() async {
    final status = await ref
        .read(managePinnedConnectionsControllerProvider.notifier)
        .checkConnectionStatus(widget.connection);

    widget.connection.status = status;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final pinnedState = ref.watch(managePinnedConnectionsControllerProvider);
    final currentConnection = pinnedState.pinnedConnections
        .followedBy(pinnedState.otherConnections)
        .firstWhere(
          (c) => c.id == widget.connection.id,
          orElse: () => widget.connection,
        );

    return FScaffold(
      header: ConnectionDetailHeader(
        connection: currentConnection,
        controller: widget.controller,
        onEdit: widget.onEdit,
        onDelete: widget.onDelete,
        onCheckConnection: widget.onCheckConnection,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
          child: Column(
            crossAxisAlignment: .start,
            spacing: Spacing.lg,
            mainAxisSize: .min,
            children: [
              ConnectionIdentitySection(connection: currentConnection),
              StorageUsageSection(connection: currentConnection),
              const QuickActionsSection(),
              const RecentFoldersAndFilesSection(),
              LandscapeWorkspacePathSection(connection: currentConnection),
            ],
          ),
        ),
      ),
    );
  }
}
