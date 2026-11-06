import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/core/models/connection_model.dart';

part 'manage_pinned_connections_controller.g.dart';

class ManagePinnedConnectionsState {
  const new({required this.pinnedConnections, required this.otherConnections});

  final List<ConnectionModel> pinnedConnections;
  final List<ConnectionModel> otherConnections;

  ManagePinnedConnectionsState copyWith({
    List<ConnectionModel>? pinnedConnections,
    List<ConnectionModel>? otherConnections,
  }) {
    return .new(
      pinnedConnections: pinnedConnections ?? this.pinnedConnections,
      otherConnections: otherConnections ?? this.otherConnections,
    );
  }
}

@Riverpod(keepAlive: true)
class ManagePinnedConnectionsController
    extends _$ManagePinnedConnectionsController {
  @override
  ManagePinnedConnectionsState build() {
    return ManagePinnedConnectionsState(
      pinnedConnections: [
        ConnectionModel(
          id: '1',
          displayName: 'Studio NAS',
          remoteAddress: '192.168.1.42',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.smb,
          createdAt: DateTime(2023, 5, 12),
          updatedAt: DateTime(2023, 5, 12),
        ),
        ConnectionModel(
          id: '2',
          displayName: 'Production',
          remoteAddress: 'prod.relaydock.io',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.sftp,
          status: ConnectionStatus.ready,
          createdAt: DateTime(2023, 5, 12),
          updatedAt: DateTime(2023, 5, 12),
        ),
        ConnectionModel(
          id: '3',
          displayName: 'Design archive',
          remoteAddress: 'dav.studio.co',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.webdav,
          status: ConnectionStatus.idle,
          createdAt: DateTime(2023, 5, 12),
          updatedAt: DateTime(2023, 5, 12),
        ),
      ],
      otherConnections: [
        ConnectionModel(
          id: '4',
          displayName: 'Finance secure',
          remoteAddress: 'secure.finance.example',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.ftps,
          status: ConnectionStatus.ready,
          createdAt: DateTime(2023, 5, 12),
          updatedAt: DateTime(2023, 5, 12),
        ),
        ConnectionModel(
          id: '5',
          displayName: 'Legacy media',
          remoteAddress: 'ftp.archive.studio',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.ftp,
          status: ConnectionStatus.offline,
          createdAt: DateTime(2023, 5, 12),
          updatedAt: DateTime(2023, 5, 12),
        ),
      ],
    );
  }

  bool pin(String id) {
    if (state.pinnedConnections.length >= 6) {
      return false;
    }

    final index = state.otherConnections.indexWhere((item) => item.id == id);
    if (index == -1) {
      return false;
    }

    final item = state.otherConnections[index];
    final other = List<ConnectionModel>.from(state.otherConnections)
      ..removeAt(index);
    final pinned = List<ConnectionModel>.from(state.pinnedConnections)
      ..add(item);

    state = state.copyWith(pinnedConnections: pinned, otherConnections: other);
    return true;
  }

  void unpin(String id) {
    final index = state.pinnedConnections.indexWhere((item) => item.id == id);
    if (index == -1) {
      return;
    }

    final item = state.pinnedConnections[index];
    final pinned = List<ConnectionModel>.from(state.pinnedConnections)
      ..removeAt(index);
    final other = List<ConnectionModel>.from(state.otherConnections)..add(item);

    state = state.copyWith(pinnedConnections: pinned, otherConnections: other);
  }
}
