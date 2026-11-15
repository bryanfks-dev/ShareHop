import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/confirmation_delete_connection_sheet.dart';
import 'package:sharehop/presentation/screens/edit_connection/screen.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class ConnectionDetailHeader extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    void handleOnPressBack() {
      context.navigator.pop();
    }

    Future<void> handleOnCheckConnection() async {
      if (onCheckConnection != null) {
        onCheckConnection!();
        return;
      }

      final status = await ref
          .read(managePinnedConnectionsControllerProvider.notifier)
          .checkConnectionStatus(connection);

      connection.status = status;

      if (context.mounted) {
        showFToast(
          context: context,
          title: Text(
            status == ConnectionStatus.online
                ? 'Connection is online'
                : 'Connection is offline',
          ),
        );
      }
    }

    void handleOnEdit() {
      if (onEdit != null) {
        onEdit!();
        return;
      }
      context.navigator.push(
        MaterialPageRoute<void>(
          builder: (routeContext) => EditConnectionScreen(
            connection: connection,
          ),
        ),
      );
    }

    Future<void> handleOnDelete() async {
      if (onDelete != null) {
        onDelete!();
        return;
      }
      await showConfirmationDeleteConnectionSheet(
        context,
        connectionName: connection.displayName,
        onConfirm: () async {
          try {
            await ref
                .read(managePinnedConnectionsControllerProvider.notifier)
                .deleteConnection(connection.id);

            if (context.mounted) {
              showFToast(
                context: context,
                title: const Text('Connection deleted successfully'),
              );
              context.navigator.pop();
            }
          } on Exception catch (_) {
            if (context.mounted) {
              showFToast(
                context: context,
                title: const Text('Failed to delete connection'),
              );
            }
          }
        },
      );
    }

    return FHeader(
      title: Row(
        spacing: Spacing.lg,
        children: [
          FButton.icon(
            size: .sm,
            onPress: handleOnPressBack,
            style: .delta(
              decoration: .delta([
                .all(const .shapeDelta(shape: CircleBorder())),
              ]),
            ),
            child: const Icon(FLucideIcons.chevronLeft),
          ),
          Expanded(
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              spacing: Spacing.dot,
              children: [
                Text(
                  connection.displayName,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: theme.typography.display.md.copyWith(
                    color: theme.colors.foreground,
                    fontWeight: .w700,
                  ),
                ),
                Text(
                  'Connection detail',
                  style: theme.typography.display.xs2.copyWith(
                    color: theme.colors.mutedForeground,
                    fontWeight: .w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      suffixes: [
        FPopoverMenu(
          control: .managed(controller: controller),
          menuAnchor: .topRight,
          childAnchor: .bottomRight,
          menuBuilder: (menuContext, controller, _) => [
            FItemGroup(
              children: [
                FItem(
                  prefix: const Icon(FLucideIcons.activity),
                  title: const Text('Check connection'),
                  onPress: () {
                    unawaited(controller.hide());
                    unawaited(handleOnCheckConnection());
                  },
                ),
                FItem(
                  prefix: const Icon(FLucideIcons.pencil),
                  title: const Text('Edit connection'),
                  onPress: () {
                    unawaited(controller.hide());
                    handleOnEdit();
                  },
                ),
                FItem(
                  variant: .destructive,
                  prefix: const Icon(FLucideIcons.trash2),
                  title: const Text('Delete connection'),
                  onPress: () {
                    unawaited(controller.hide());
                    unawaited(handleOnDelete());
                  },
                ),
              ],
            ),
          ],
          builder: (buttonContext, controller, _) => FButton.icon(
            size: .sm,
            onPress: controller.toggle,
            style: .delta(
              decoration: .delta([
                .all(const .shapeDelta(shape: CircleBorder())),
              ]),
            ),
            child: const Icon(FLucideIcons.ellipsis),
          ),
        ),
      ],
    );
  }
}
