import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

part 'connections_controller.g.dart';

@Riverpod(keepAlive: true)
class ConnectionsController extends _$ConnectionsController {
  @override
  List<ConnectionViewModel> build() {
    return ref
        .watch(managePinnedConnectionsControllerProvider)
        .pinnedConnections;
  }

  List<ConnectionViewModel> getPinnedConnections() {
    return ref
        .read(managePinnedConnectionsControllerProvider)
        .pinnedConnections;
  }

  ConnectionViewModel? getPinnedConnection({String? id}) {
    final pinned = getPinnedConnections();
    if (id == null) {
      return pinned.firstOrNull;
    }
    return pinned.where((connection) => connection.id == id).firstOrNull;
  }
}
