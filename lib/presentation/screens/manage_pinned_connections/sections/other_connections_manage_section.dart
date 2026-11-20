import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/connection_detail/screen.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_empty_state.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_filter_chips.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_tile_group.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class OtherConnectionsManageSection extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(managePinnedConnectionsControllerProvider);
    final other = state.filteredOtherConnections;

    void handleOnPressPin({required ConnectionViewModel connection}) {
      final success = ref
          .read(managePinnedConnectionsControllerProvider.notifier)
          .pin(connection.id);

      if (!success && context.mounted) {
        showFToast(
          context: context,
          title: Text(
            'You can only pin up to 6 connections.',
            style: theme.typography.body.sm.copyWith(
              color: theme.colors.foreground,
            ),
          ),
        );
      }
    }

    void handleOnPressEdit({required ConnectionViewModel connection}) {
      context.navigator.push(
        MaterialPageRoute<ConnectionDetailScreen>(
          builder: (context) => ConnectionDetailScreen(connection: connection),
        ),
      );
    }

    void handleOnPressFilterProtocol({required ConnectionProtocol? protocol}) {
      ref
          .read(managePinnedConnectionsControllerProvider.notifier)
          .filterByProtocol(protocol);
    }

    return Column(
      crossAxisAlignment: .start,
      spacing: Spacing.sm,
      mainAxisSize: .min,
      children: [
        Text(
          'Other Connections (${other.length})',
          style: theme.typography.display.xs2.copyWith(
            color: theme.colors.foreground,
            fontWeight: .w700,
          ),
        ),
        ManageOtherConnectionsFilterChips(
          selectedProtocol: state.selectedProtocol,
          onPressProtocol: handleOnPressFilterProtocol,
        ),
        Builder(
          builder: (context) {
            if (other.isEmpty) {
              return const ManageOtherConnectionsEmptyState();
            }

            return ManageOtherConnectionsTileGroup(
              otherConnections: other,
              onPressPin: handleOnPressPin,
              onPressEdit: handleOnPressEdit,
            );
          },
        ),
      ],
    );
  }
}
