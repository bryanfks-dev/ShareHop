import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_connection_tile.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class ManageOtherConnectionsTileGroup extends StatelessWidget {
  const new({
    required this.otherConnections,
    required this.onPressPin,
    required this.onPressEdit,
    super.key,
  });

  final List<ConnectionViewModel> otherConnections;
  final void Function({required ConnectionViewModel connection}) onPressPin;
  final void Function({required ConnectionViewModel connection}) onPressEdit;

  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      divider: .full,
      children: [
        for (final connection in otherConnections)
          ManageConnectionTile(
            key: ValueKey(connection.id),
            connection: connection,
            onPressPin: () => onPressPin(connection: connection),
            onPressEdit: () => onPressEdit(connection: connection),
          ),
      ],
    );
  }
}
