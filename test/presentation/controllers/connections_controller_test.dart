import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/presentation/controllers/connections_controller.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:uuid/uuid.dart';

class _FakeConnRepo implements ConnectionRepository {
  new(this.connections);
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

class _FakePinnedRepo implements PinnedConnectionRepository {
  new(this.pinnedIds);
  final Set<UuidValue> pinnedIds;

  @override
  Future<List<PinnedConnectionModel>> getAll() async {
    final now = DateTime.now().toUtc();
    return pinnedIds
        .map((id) => PinnedConnectionModel(
              connectionId: id,
              createdAt: now,
              updatedAt: now,
            ))
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
  group('ConnectionsController', () {
    late UuidValue id1;
    late UuidValue id2;
    late UuidValue id3;
    late UuidValue id4;
    late List<ConnectionModel> connections;
    late Set<UuidValue> pinnedIds;

    setUp(() {
      id1 = const Uuid().v7obj();
      id2 = const Uuid().v7obj();
      id3 = const Uuid().v7obj();
      id4 = const Uuid().v7obj();
      connections = [
        _createTestModel(id: id1, displayName: 'First NAS'),
        _createTestModel(id: id2, displayName: 'Production'),
        _createTestModel(id: id3, displayName: 'Design archive'),
        _createTestModel(id: id4, displayName: 'Other 4'),
      ];
      pinnedIds = {id1, id2, id3};
    });

    ProviderContainer createContainer() {
      return ProviderContainer(
        overrides: [
          connectionRepositoryProvider
              .overrideWithValue(_FakeConnRepo(connections)),
          pinnedConnectionRepositoryProvider
              .overrideWithValue(_FakePinnedRepo(pinnedIds)),
        ],
      );
    }

    test('initializes with pinned connections from '
        'managePinnedConnectionsController', () async {
      final container = createContainer();
      await container
          .read(managePinnedConnectionsControllerProvider.notifier)
          .refresh();

      final list = container.read(connectionsControllerProvider);
      expect(list.length, 3);
      expect(list[0].displayName, 'First NAS');
      expect(list[1].displayName, 'Production');
      expect(list[2].displayName, 'Design archive');
    });

    test('updates reactively when a connection is unpinned', () async {
      final container = createContainer();
      final manageController = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );
      await manageController.refresh();

      expect(container.read(connectionsControllerProvider).length, 3);

      manageController.unpin(id1);

      final updated = container.read(connectionsControllerProvider);
      expect(updated.length, 2);
      expect(updated.any((c) => c.id == id1), isFalse);
    });

    test('updates reactively when a connection is pinned', () async {
      final container = createContainer();
      final manageController = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );
      await manageController.refresh();

      expect(container.read(connectionsControllerProvider).length, 3);

      final success = manageController.pin(id4);
      expect(success, isTrue);

      final updated = container.read(connectionsControllerProvider);
      expect(updated.length, 4);
      expect(updated.any((c) => c.id == id4), isTrue);
    });

    test('getPinnedConnections returns all pinned connections', () async {
      final container = createContainer();
      final controller =
          container.read(connectionsControllerProvider.notifier);
      await container
          .read(managePinnedConnectionsControllerProvider.notifier)
          .refresh();

      final pinned = controller.getPinnedConnections();
      expect(pinned.length, 3);
      expect(pinned[0].id, id1);
      expect(pinned[1].id, id2);
      expect(pinned[2].id, id3);
    });

    test(
      'getPinnedConnection without id returns the first pinned connection',
      () async {
        final container = createContainer();
        final controller =
            container.read(connectionsControllerProvider.notifier);
        await container
            .read(managePinnedConnectionsControllerProvider.notifier)
            .refresh();

        final first = controller.getPinnedConnection();
        expect(first, isNotNull);
        expect(first?.id, id1);
        expect(first?.displayName, 'First NAS');
      },
    );

    test('getPinnedConnection with id returns matching connection', () async {
      final container = createContainer();
      final controller =
          container.read(connectionsControllerProvider.notifier);
      await container
          .read(managePinnedConnectionsControllerProvider.notifier)
          .refresh();

      final connection = controller.getPinnedConnection(id: id2);
      expect(connection, isNotNull);
      expect(connection?.id, id2);
      expect(connection?.displayName, 'Production');
    });

    test('getPinnedConnection with non-existent id returns null', () async {
      final container = createContainer();
      final controller =
          container.read(connectionsControllerProvider.notifier);
      await container
          .read(managePinnedConnectionsControllerProvider.notifier)
          .refresh();

      final connection =
          controller.getPinnedConnection(id: const Uuid().v7obj());
      expect(connection, isNull);
    });
  });
}
