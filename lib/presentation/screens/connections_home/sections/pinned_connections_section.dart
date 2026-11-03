import 'package:flutter/material.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/button.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/connection/connection_list_empty_state.dart';
import 'package:sharehop/presentation/widgets/connection/connection_list_tile.dart';

final _mockConnection = [
  ConnectionModel(
    id: '1',
    displayName: 'Studio NAS',
    remoteAddress: '192.168.1.42',
    protocol: .sftp,
    createdAt: DateTime(2023, 5, 12),
    updatedAt: DateTime(2023, 5, 12),
  ),
  ConnectionModel(
    id: '2',
    displayName: 'Mary Smith',
    remoteAddress: 'prod.relaydock.io',
    protocol: .ftp,
    createdAt: DateTime(2023, 5, 12),
    updatedAt: DateTime(2023, 5, 12),
  ),
];

class PinnedConnectionsSection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressManage() {}

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
            if (_mockConnection.isEmpty) {
              return const ConnectionListEmptyState();
            }
            return ConnectionListTile(connections: _mockConnection);
          },
        ),
      ],
    );
  }
}
