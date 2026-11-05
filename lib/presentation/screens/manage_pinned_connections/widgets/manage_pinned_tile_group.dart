import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_connection_tile.dart';

class ManagePinnedTileGroup extends StatelessWidget {
  const new({
    required this.pinnedConnections,
    required this.onPressUnpin,
    required this.onPressEdit,
    super.key,
  });

  final List<ConnectionModel> pinnedConnections;
  final void Function({required ConnectionModel connection}) onPressUnpin;
  final void Function({required ConnectionModel connection}) onPressEdit;

  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      divider: .full,
      children: [
        for (final connection in pinnedConnections)
          ManageConnectionTile(
            key: ValueKey(connection.id),
            connection: connection,
            isPinned: true,
            onPressUnpin: () => onPressUnpin(connection: connection),
            onPressEdit: () => onPressEdit(connection: connection),
          ),
      ],
    );
  }
}
