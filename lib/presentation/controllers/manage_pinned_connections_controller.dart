import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid_value.dart';

part 'manage_pinned_connections_controller.g.dart';

@Riverpod(keepAlive: true)
class ManagePinnedConnectionsController
    extends _$ManagePinnedConnectionsController {
  @override
  ManagePinnedConnectionsState build() {
    unawaited(_loadConnections());
    return const ManagePinnedConnectionsState(
      pinnedConnections: [],
      otherConnections: [],
    );
  }

  Future<void> _loadConnections() async {
    try {
      final connectionRepository = ref.read(connectionRepositoryProvider);
      final pinnedConnectionRepository =
          ref.read(pinnedConnectionRepositoryProvider);
      final connectionMapper = ref.read(connectionMapperProvider);

      final allConnections = await connectionRepository.getAll();
      final pinnedIds =
          await pinnedConnectionRepository.getPinnedConnectionIds();

      final pinned = <ConnectionViewModel>[];
      final other = <ConnectionViewModel>[];

      for (final connection in allConnections) {
        final isPinned = pinnedIds.contains(connection.id);
        final viewModel = connectionMapper.toConnectionViewModel(
          connection,
          isPinned: isPinned,
        );
        if (isPinned) {
          pinned.add(viewModel);
        } else {
          other.add(viewModel);
        }
      }

      state = ManagePinnedConnectionsState(
        pinnedConnections: pinned,
        otherConnections: other,
        selectedProtocol: state.selectedProtocol,
      );
    } on Object catch (e, st) {
      log(
        'Failed to load connections',
        name: 'ManagePinnedConnectionsController',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> refresh() => _loadConnections();

  Future<ConnectionStatus> checkConnectionStatus(
    ConnectionViewModel connection,
  ) async {
    try {
      final status = await ref
          .read(checkConnectionStatusUseCaseProvider)
          .call(connection: connection);

      updateStatus(connection.id, status);
      return status;
    } on Exception {
      updateStatus(connection.id, ConnectionStatus.offline);
      return ConnectionStatus.offline;
    }
  }

  Future<void> deleteConnection(UuidValue id) async {
    await ref.read(pinnedConnectionRepositoryProvider).unpin(id);
    await ref.read(connectionRepositoryProvider).remove(id);
    await refresh();
  }

  void updateStatus(UuidValue id, ConnectionStatus status) {
    var changed = false;
    final newPinned = state.pinnedConnections.map((c) {
      if (c.id == id) {
        c.status = status;
        changed = true;
      }
      return c;
    }).toList();

    final newOther = state.otherConnections.map((c) {
      if (c.id == id) {
        c.status = status;
        changed = true;
      }
      return c;
    }).toList();

    if (changed) {
      state = state.copyWith(
        pinnedConnections: newPinned,
        otherConnections: newOther,
      );
    }
  }

  bool pin(UuidValue id) {
    if (state.pinnedConnections.length >= 6) {
      return false;
    }

    final index = state.otherConnections.indexWhere((item) => item.id == id);
    if (index == -1) {
      return false;
    }

    final item = state.otherConnections[index]..isPinned = true;
    final other = List<ConnectionViewModel>.from(state.otherConnections)
      ..removeAt(index);
    final pinned = List<ConnectionViewModel>.from(state.pinnedConnections)
      ..add(item);

    state = state.copyWith(pinnedConnections: pinned, otherConnections: other);

    unawaited(
      ref
          .read(pinConnectionUseCaseProvider)
          .call(connectionId: id)
          .catchError((Object error, StackTrace st) {
            log(
              'Failed to persist pinned connection',
              name: 'ManagePinnedConnectionsController.pin',
              error: error,
              stackTrace: st,
            );
            unawaited(_loadConnections());
            return false;
          }),
    );

    return true;
  }

  void unpin(UuidValue id) {
    final index = state.pinnedConnections.indexWhere((item) => item.id == id);
    if (index == -1) {
      return;
    }

    final item = state.pinnedConnections[index]..isPinned = false;
    final pinned = List<ConnectionViewModel>.from(state.pinnedConnections)
      ..removeAt(index);
    final other = List<ConnectionViewModel>.from(state.otherConnections)
      ..add(item);

    state = state.copyWith(pinnedConnections: pinned, otherConnections: other);

    unawaited(
      ref
          .read(pinnedConnectionRepositoryProvider)
          .unpin(id)
          .catchError((Object error, StackTrace st) {
            log(
              'Failed to persist unpinned connection',
              name: 'ManagePinnedConnectionsController.unpin',
              error: error,
              stackTrace: st,
            );
            unawaited(_loadConnections());
          }),
    );
  }

  void filterByProtocol(ConnectionProtocol? protocol) {
    if (protocol == null || state.selectedProtocol == protocol) {
      state = state.copyWith(selectedProtocol: () => null);
    } else {
      state = state.copyWith(selectedProtocol: () => protocol);
    }
  }
}

class ManagePinnedConnectionsState {
  const new({
    required this.pinnedConnections,
    required this.otherConnections,
    this.selectedProtocol,
  });

  final List<ConnectionViewModel> pinnedConnections;
  final List<ConnectionViewModel> otherConnections;
  final ConnectionProtocol? selectedProtocol;

  List<ConnectionViewModel> get filteredOtherConnections {
    final protocol = selectedProtocol;
    if (protocol == null) {
      return otherConnections;
    }

    return otherConnections
        .where((connection) => connection.protocol == protocol)
        .toList();
  }

  ManagePinnedConnectionsState copyWith({
    List<ConnectionViewModel>? pinnedConnections,
    List<ConnectionViewModel>? otherConnections,
    ConnectionProtocol? Function()? selectedProtocol,
  }) {
    return .new(
      pinnedConnections: pinnedConnections ?? this.pinnedConnections,
      otherConnections: otherConnections ?? this.otherConnections,
      selectedProtocol: selectedProtocol != null
          ? selectedProtocol()
          : this.selectedProtocol,
    );
  }
}
