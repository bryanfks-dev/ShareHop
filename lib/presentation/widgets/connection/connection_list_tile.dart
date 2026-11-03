import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/connection_detail/screen.dart';
import 'package:sharehop/presentation/widgets/connection/connection_tile.dart';

class ConnectionListTile extends StatelessWidget {
  const new({required this.connections, super.key});

  final List<ConnectionModel> connections;

  @override
  Widget build(BuildContext context) {
    void handleOnPressConnection({required ConnectionModel connection}) {
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

        return ConnectionTile(
          connection: connection,
          onPress: handleOnPress,
        );
      },
    );
  }
}
