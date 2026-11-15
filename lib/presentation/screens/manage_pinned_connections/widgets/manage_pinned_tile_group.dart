import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_connection_tile.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class ManagePinnedTileGroup extends StatelessWidget {
  const new({
    required this.pinnedConnections,
    required this.onPressUnpin,
    required this.onPressEdit,
    super.key,
  });

  final List<ConnectionViewModel> pinnedConnections;
  final void Function({required ConnectionViewModel connection}) onPressUnpin;
  final void Function({required ConnectionViewModel connection}) onPressEdit;

  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      divider: .full,
      children: [
        for (final connection in pinnedConnections)
          ManageConnectionTile(
            key: ValueKey(connection.id),
            connection: connection,
            onPressUnpin: () => onPressUnpin(connection: connection),
            onPressEdit: () => onPressEdit(connection: connection),
          ),
      ],
    );
  }
}
