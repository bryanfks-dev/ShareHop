import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/connection_detail/screen.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_pinned_empty_state.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_pinned_tile_group.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class PinnedConnectionsManageSection extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(managePinnedConnectionsControllerProvider);
    final pinned = state.pinnedConnections;

    void handleOnPressUnpin({required ConnectionModel connection}) {
      ref
          .read(managePinnedConnectionsControllerProvider.notifier)
          .unpin(connection.id);
    }

    void handleOnPressEdit({required ConnectionModel connection}) {
      context.navigator.push(
        MaterialPageRoute<ConnectionDetailScreen>(
          builder: (context) => ConnectionDetailScreen(connection: connection),
        ),
      );
    }

    return Column(
      crossAxisAlignment: .start,
      spacing: Spacing.sm,
      mainAxisSize: .min,
      children: [
        Text(
          'PINNED (${pinned.length})',
          style: theme.typography.display.xs2.copyWith(
            color: theme.colors.mutedForeground,
            fontWeight: .w700,
            letterSpacing: 0.5,
          ),
        ),
        Builder(
          builder: (context) {
            if (pinned.isEmpty) {
              return const ManagePinnedEmptyState();
            }

            return ManagePinnedTileGroup(
              pinnedConnections: pinned,
              onPressUnpin: handleOnPressUnpin,
              onPressEdit: handleOnPressEdit,
            );
          },
        ),
      ],
    );
  }
}
