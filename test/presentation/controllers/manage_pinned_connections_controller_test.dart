import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

class FakeConnectionRepository implements ConnectionRepository {
  new({List<ConnectionModel>? initial}) : connections = initial ?? [];

  final List<ConnectionModel> connections;

  @override
  Future<List<ConnectionModel>> getAll() async => connections;

  @override
  Future<ConnectionModel?> getOne(UuidValue id) async =>
      connections.where((c) => c.id == id).firstOrNull;

  @override
  Future<ConnectionModel> create(ConnectionModel connection) async {
    connections.add(connection);
    return connection;
  }

  @override
  Future<ConnectionModel?> update(ConnectionModel connection) async => null;

  @override
  Future<void> remove(UuidValue id) async {
    connections.removeWhere((c) => c.id == id);
  }

  @override
  Future<void> batchRemove(Set<UuidValue> ids) async {
    connections.removeWhere((c) => ids.contains(c.id));
  }

  @override
  Future<Set<UuidValue>> checkIfExists(Set<UuidValue> ids) async =>
      connections.map((c) => c.id).toSet().intersection(ids);
}

class FakePinnedConnectionRepository implements PinnedConnectionRepository {
  new({Set<UuidValue>? initial}) : pinnedIds = initial ?? {};

  final Set<UuidValue> pinnedIds;

  @override
  Future<List<PinnedConnectionModel>> getAll() async {
    final now = DateTime.now().toUtc();
    return pinnedIds
        .map(
          (id) => PinnedConnectionModel(
            connectionId: id,
            createdAt: now,
            updatedAt: now,
          ),
        )
        .toList();
  }

  @override
  Future<Set<UuidValue>> getPinnedConnectionIds() async => Set.from(pinnedIds);

  @override
  Future<void> pin(UuidValue connectionId) async {
    pinnedIds.add(connectionId);
  }

  @override
  Future<void> unpin(UuidValue connectionId) async {
    pinnedIds.remove(connectionId);
  }
}

ConnectionModel _createTestModel({
  required UuidValue id,
  required String displayName,
}) {
  final now = DateTime.now().toUtc();
  final passwordId = const Uuid().v7obj();
  return ConnectionModel(
    id: id,
    protocol: ConnectionProtocol.webdav,
    displayName: displayName,
    remoteAddress: 'https://example.com',
    username: 'user',
    passwordId: passwordId,
    password: EncryptedValueModel(
      id: passwordId,
      salt: '',
      nonce: '',
      cipherText: 'pwd',
      mac: '',
      createdAt: now,
      updatedAt: now,
    ),
    rootPath: '/',
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  group('ManagePinnedConnectionsController', () {
    test(
      'loads real connections from repository into pinned and other',
      () async {
        final conn1 = _createTestModel(
          id: const Uuid().v7obj(),
          displayName: 'Pinned 1',
        );
        final conn2 = _createTestModel(
          id: const Uuid().v7obj(),
          displayName: 'Other 1',
        );

        final fakeConnRepo = FakeConnectionRepository(
          initial: [conn1, conn2],
        );
        final fakePinnedRepo = FakePinnedConnectionRepository(
          initial: {conn1.id},
        );

        final container = ProviderContainer(
          overrides: [
            connectionRepositoryProvider.overrideWithValue(fakeConnRepo),
            pinnedConnectionRepositoryProvider
                .overrideWithValue(fakePinnedRepo),
          ],
        );

        final notifier = container.read(
          managePinnedConnectionsControllerProvider.notifier,
        );
        await notifier.refresh();

        final state = container.read(managePinnedConnectionsControllerProvider);
        expect(state.pinnedConnections.length, 1);
        expect(state.otherConnections.length, 1);
        expect(state.pinnedConnections.first.id, conn1.id);
        expect(state.pinnedConnections.first.displayName, 'Pinned 1');
        expect(state.pinnedConnections.first.isPinned, isTrue);
        expect(state.otherConnections.first.id, conn2.id);
        expect(state.otherConnections.first.displayName, 'Other 1');
        expect(state.otherConnections.first.isPinned, isFalse);
      },
    );

    test(
      'pin moves a connection from other to pinned and persists to repo',
      () async {
        final conn = _createTestModel(
          id: const Uuid().v7obj(),
          displayName: 'To Pin',
        );

        final fakeConnRepo = FakeConnectionRepository(initial: [conn]);
        final fakePinnedRepo = FakePinnedConnectionRepository();

        final container = ProviderContainer(
          overrides: [
            connectionRepositoryProvider.overrideWithValue(fakeConnRepo),
            pinnedConnectionRepositoryProvider
                .overrideWithValue(fakePinnedRepo),
          ],
        );

        final notifier = container.read(
          managePinnedConnectionsControllerProvider.notifier,
        );
        await notifier.refresh();

        final success = notifier.pin(conn.id);
        expect(success, isTrue);

        final state = container.read(managePinnedConnectionsControllerProvider);
        expect(state.pinnedConnections.length, 1);
        expect(state.otherConnections.length, 0);
        expect(state.pinnedConnections.first.id, conn.id);
        expect(state.pinnedConnections.first.isPinned, isTrue);

        // allow unawaited async persistence to complete
        await pumpEventQueue();
        expect(fakePinnedRepo.pinnedIds, contains(conn.id));
      },
    );

    test(
      'pin returns false when connection id is not found in other',
      () async {
        final container = ProviderContainer(
          overrides: [
            connectionRepositoryProvider
                .overrideWithValue(FakeConnectionRepository()),
            pinnedConnectionRepositoryProvider
                .overrideWithValue(FakePinnedConnectionRepository()),
          ],
        );

        final notifier = container.read(
          managePinnedConnectionsControllerProvider.notifier,
        );
        await notifier.refresh();

        final success = notifier.pin(const Uuid().v7obj());
        expect(success, isFalse);
      },
    );

    test('pin returns false when limit of 6 is reached', () async {
      final connections = List.generate(
        7,
        (i) => _createTestModel(
          id: const Uuid().v7obj(),
          displayName: 'Conn $i',
        ),
      );

      final pinnedIds = connections.take(6).map((c) => c.id).toSet();
      final fakeConnRepo = FakeConnectionRepository(initial: connections);
      final fakePinnedRepo = FakePinnedConnectionRepository(
        initial: pinnedIds,
      );

      final container = ProviderContainer(
        overrides: [
          connectionRepositoryProvider.overrideWithValue(fakeConnRepo),
          pinnedConnectionRepositoryProvider
              .overrideWithValue(fakePinnedRepo),
        ],
      );

      final notifier = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );
      await notifier.refresh();

      expect(
        container
            .read(managePinnedConnectionsControllerProvider)
            .pinnedConnections
            .length,
        6,
      );

      final success = notifier.pin(connections[6].id);
      expect(success, isFalse);
    });

    test(
      'unpin moves connection from pinned to other and removes from repo',
      () async {
        final conn = _createTestModel(
          id: const Uuid().v7obj(),
          displayName: 'Pinned',
        );

        final fakeConnRepo = FakeConnectionRepository(initial: [conn]);
        final fakePinnedRepo = FakePinnedConnectionRepository(
          initial: {conn.id},
        );

        final container = ProviderContainer(
          overrides: [
            connectionRepositoryProvider.overrideWithValue(fakeConnRepo),
            pinnedConnectionRepositoryProvider
                .overrideWithValue(fakePinnedRepo),
          ],
        );

        final notifier = container.read(
          managePinnedConnectionsControllerProvider.notifier,
        );
        await notifier.refresh();

        notifier.unpin(conn.id);

        final state = container.read(managePinnedConnectionsControllerProvider);
        expect(state.pinnedConnections, isEmpty);
        expect(state.otherConnections.length, 1);
        expect(state.otherConnections.first.id, conn.id);
        expect(state.otherConnections.first.isPinned, isFalse);

        await pumpEventQueue();
        expect(fakePinnedRepo.pinnedIds, isEmpty);
      },
    );

    test(
      'updateStatus updates status of pinned and other connections',
      () async {
      final conn1 = _createTestModel(
        id: const Uuid().v7obj(),
        displayName: 'Conn 1',
      );
      final conn2 = _createTestModel(
        id: const Uuid().v7obj(),
        displayName: 'Conn 2',
      );
      final fakeConnRepo = FakeConnectionRepository(initial: [conn1, conn2]);
      final fakePinnedRepo = FakePinnedConnectionRepository(
        initial: {conn1.id},
      );

      final container = ProviderContainer(
        overrides: [
          connectionRepositoryProvider.overrideWithValue(fakeConnRepo),
          pinnedConnectionRepositoryProvider.overrideWithValue(fakePinnedRepo),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );

      await pumpEventQueue();

      notifier.updateStatus(conn1.id, ConnectionStatus.online);
      var state = container.read(managePinnedConnectionsControllerProvider);
      expect(
        state.pinnedConnections.firstWhere((c) => c.id == conn1.id).status,
        ConnectionStatus.online,
      );

      notifier.updateStatus(conn2.id, ConnectionStatus.offline);
      state = container.read(managePinnedConnectionsControllerProvider);
      expect(
        state.otherConnections.firstWhere((c) => c.id == conn2.id).status,
        ConnectionStatus.offline,
      );
    });

    test(
      'ManagePinnedConnectionsState copyWith preserves or updates values',
      () {
        final item = ConnectionViewModel(
          id: const Uuid().v7obj(),
          displayName: 'Test',
          remoteAddress: '127.0.0.1',
          username: 'u',
          password: 'p',
          protocol: ConnectionProtocol.smb,
          isPinned: true,
        );

        final state = ManagePinnedConnectionsState(
          pinnedConnections: [item],
          otherConnections: const [],
        );

        final copiedSame = state.copyWith();
        expect(copiedSame.pinnedConnections.length, 1);
        expect(copiedSame.otherConnections.length, 0);

        final copiedNew = state.copyWith(
          pinnedConnections: const [],
          otherConnections: [item],
        );
        expect(copiedNew.pinnedConnections.length, 0);
        expect(copiedNew.otherConnections.length, 1);
      },
    );

    test(
      'filterByProtocol sets, toggles off, and resets selectedProtocol',
      () async {
        final id1 = const Uuid().v7obj();
        final id2 = const Uuid().v7obj();
        final connRepo = FakeConnectionRepository(
          initial: [
            _createTestModel(id: id1, displayName: 'FTP Server')
                .copyWith(protocol: ConnectionProtocol.ftp),
            _createTestModel(id: id2, displayName: 'SFTP Server')
                .copyWith(protocol: ConnectionProtocol.sftp),
          ],
        );
        final pinnedRepo = FakePinnedConnectionRepository();
        final container = ProviderContainer(
          overrides: [
            connectionRepositoryProvider.overrideWithValue(connRepo),
            pinnedConnectionRepositoryProvider.overrideWithValue(pinnedRepo),
          ],
        );

        final controller = container.read(
          managePinnedConnectionsControllerProvider.notifier,
        );
        await Future<void>.delayed(Duration.zero);

        expect(
          container
              .read(managePinnedConnectionsControllerProvider)
              .selectedProtocol,
          isNull,
        );
        expect(
          container
              .read(managePinnedConnectionsControllerProvider)
              .filteredOtherConnections
              .length,
          2,
        );

        // Filter by FTP
        controller.filterByProtocol(ConnectionProtocol.ftp);
        expect(
          container
              .read(managePinnedConnectionsControllerProvider)
              .selectedProtocol,
          ConnectionProtocol.ftp,
        );
        expect(
          container
              .read(managePinnedConnectionsControllerProvider)
              .filteredOtherConnections
              .map((c) => c.displayName),
          ['FTP Server'],
        );

        // Toggle off by selecting FTP again
        controller.filterByProtocol(ConnectionProtocol.ftp);
        expect(
          container
              .read(managePinnedConnectionsControllerProvider)
              .selectedProtocol,
          isNull,
        );
        expect(
          container
              .read(managePinnedConnectionsControllerProvider)
              .filteredOtherConnections
              .length,
          2,
        );

        // Filter by SFTP then reset with null
        controller.filterByProtocol(ConnectionProtocol.sftp);
        expect(
          container
              .read(managePinnedConnectionsControllerProvider)
              .selectedProtocol,
          ConnectionProtocol.sftp,
        );
        controller.filterByProtocol(null);
        expect(
          container
              .read(managePinnedConnectionsControllerProvider)
              .selectedProtocol,
          isNull,
        );
      },
    );

    test(
      'ManagePinnedConnectionsState copyWith preserves or updates '
      'selectedProtocol',
      () {
        const state = ManagePinnedConnectionsState(
          pinnedConnections: [],
          otherConnections: [],
          selectedProtocol: ConnectionProtocol.smb,
        );

        final copiedSame = state.copyWith();
        expect(copiedSame.selectedProtocol, ConnectionProtocol.smb);

        final copiedNew = state.copyWith(
          selectedProtocol: () => ConnectionProtocol.webdav,
        );
        expect(copiedNew.selectedProtocol, ConnectionProtocol.webdav);

        final copiedNull = state.copyWith(
          selectedProtocol: () => null,
        );
        expect(copiedNull.selectedProtocol, isNull);
      },
    );
  });
}
