import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_connection_tile.dart';

class ManageOtherConnectionsTileGroup extends StatelessWidget {
  const new({
    required this.otherConnections,
    required this.onPressPin,
    required this.onPressEdit,
    super.key,
  });

  final List<ConnectionModel> otherConnections;
  final void Function({required ConnectionModel connection}) onPressPin;
  final void Function({required ConnectionModel connection}) onPressEdit;

  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      divider: .full,
      children: [
        for (final connection in otherConnections)
          ManageConnectionTile(
            key: ValueKey(connection.id),
            connection: connection,
            isPinned: false,
            onPressPin: () => onPressPin(connection: connection),
            onPressEdit: () => onPressEdit(connection: connection),
          ),
      ],
    );
  }
}
