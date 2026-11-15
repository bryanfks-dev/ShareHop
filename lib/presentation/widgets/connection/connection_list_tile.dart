import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/connection_detail/screen.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_tile.dart';

class ConnectionListTile extends StatelessWidget {
  const new({required this.connections, super.key});

  final List<ConnectionViewModel> connections;

  @override
  Widget build(BuildContext context) {
    void handleOnPressConnection({required ConnectionViewModel connection}) {
      context.navigator.push(
        MaterialPageRoute<ConnectionDetailScreen>(
          builder: (routeContext) =>
              ConnectionDetailScreen(connection: connection),
        ),
      );
    }

    return FTileGroup.builder(
      divider: .full,
      count: connections.length,
      tileBuilder: (context, index) {
        final connection = connections[index];

        void handleOnPress() {
          handleOnPressConnection(connection: connection);
        }

        return ConnectionTile(connection: connection, onPress: handleOnPress);
      },
    );
  }
}
