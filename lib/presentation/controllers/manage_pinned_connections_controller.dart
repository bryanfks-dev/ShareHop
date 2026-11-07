import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

part 'manage_pinned_connections_controller.g.dart';

@Riverpod(keepAlive: true)
class ManagePinnedConnectionsController
    extends _$ManagePinnedConnectionsController {
  @override
  ManagePinnedConnectionsState build() {
    return ManagePinnedConnectionsState(
      pinnedConnections: [
        ConnectionViewModel(
          id: '1',
          displayName: 'Studio NAS',
          remoteAddress: '192.168.1.42',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.smb,
          isPinned: true,
        ),
        ConnectionViewModel(
          id: '2',
          displayName: 'Production',
          remoteAddress: 'prod.relaydock.io',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.sftp,
          status: ConnectionStatus.ready,
          isPinned: true,
        ),
        ConnectionViewModel(
          id: '3',
          displayName: 'Design archive',
          remoteAddress: 'dav.studio.co',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.webdav,
          isPinned: true,
        ),
      ],
      otherConnections: [
        ConnectionViewModel(
          id: '4',
          displayName: 'Finance secure',
          remoteAddress: 'secure.finance.example',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.ftps,
          status: ConnectionStatus.ready,
          isPinned: false,
        ),
        ConnectionViewModel(
          id: '5',
          displayName: 'Legacy media',
          remoteAddress: 'ftp.archive.studio',
          username: 'admin',
          password: 'password123',
          protocol: ConnectionProtocol.ftp,
          status: ConnectionStatus.offline,
          isPinned: false,
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
    final other = List<ConnectionViewModel>.from(state.otherConnections)
      ..removeAt(index);
    final pinned = List<ConnectionViewModel>.from(state.pinnedConnections)
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
    final pinned = List<ConnectionViewModel>.from(state.pinnedConnections)
      ..removeAt(index);
    final other = List<ConnectionViewModel>.from(state.otherConnections)
      ..add(item);

    state = state.copyWith(pinnedConnections: pinned, otherConnections: other);
  }
}

class ManagePinnedConnectionsState {
  const new({required this.pinnedConnections, required this.otherConnections});

  final List<ConnectionViewModel> pinnedConnections;
  final List<ConnectionViewModel> otherConnections;

  ManagePinnedConnectionsState copyWith({
    List<ConnectionViewModel>? pinnedConnections,
    List<ConnectionViewModel>? otherConnections,
  }) {
    return .new(
      pinnedConnections: pinnedConnections ?? this.pinnedConnections,
      otherConnections: otherConnections ?? this.otherConnections,
    );
  }
}
