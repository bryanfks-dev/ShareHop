import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/button.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/screen.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/connection/connection_list_empty_state.dart';
import 'package:sharehop/presentation/widgets/connection/connection_list_tile.dart';

class PinnedConnectionsSection extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(managePinnedConnectionsControllerProvider);
    final pinnedConnections = state.pinnedConnections;

    void handleOnPressManage() {
      context.navigator.push(
        MaterialPageRoute<void>(
          builder: (context) => const ManagePinnedConnectionsScreen(),
        ),
      );
    }

    return Column(
      spacing: Spacing.sm,
      mainAxisSize: .min,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'PINNED CONNECTIONS',
              style: theme.typography.display.xs.copyWith(
                color: theme.colors.foreground,
                fontWeight: .w700,
              ),
            ),
            FButton(
              variant: .ghost,
              size: .xs,
              onPress: handleOnPressManage,
              child: Text(
                'Manage',
                style: theme.typography.display.xs.copyWith(
                  color: theme.colors.primary,
                  fontWeight: .w600,
                ),
              ),
            ),
          ],
        ),
        Builder(
          builder: (context) {
            if (pinnedConnections.isEmpty) {
              return const ConnectionListEmptyState();
            }
            return ConnectionListTile(connections: pinnedConnections);
          },
        ),
      ],
    );
  }
}
