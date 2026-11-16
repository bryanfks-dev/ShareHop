import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:sharehop/core/use_cases/delete_connection_use_case.dart';
import 'package:sharehop/core/use_cases/get_connections_use_case.dart';
import 'package:sharehop/core/use_cases/get_pinned_connection_ids_use_case.dart';
import 'package:sharehop/core/use_cases/unpin_connection_use_case.dart';
import 'package:uuid/uuid.dart';

class _FakeConnectionRepository implements ConnectionRepository {
  new({List<ConnectionModel>? initial}) : connections = initial ?? [];

  final List<ConnectionModel> connections;

  @override
  Future<List<ConnectionModel>> getAll() async => List.from(connections);

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

  Future<int> clear() async {
    final count = connections.length;
    connections.clear();
    return count;
  }
}

class _FakePinnedConnectionRepository implements PinnedConnectionRepository {
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

ConnectionModel _buildConnection({
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
    rootPath: '/',
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  group('GetConnectionsUseCase', () {
    test('returns all connections from repository', () async {
      final id1 = UuidValue.fromString(const Uuid().v4());
      final id2 = UuidValue.fromString(const Uuid().v4());
      final conn1 = _buildConnection(id: id1, displayName: 'Conn 1');
      final conn2 = _buildConnection(id: id2, displayName: 'Conn 2');

      final repo = _FakeConnectionRepository(initial: [conn1, conn2]);
      final useCase = GetConnectionsUseCase(connectionRepository: repo);

      final result = await useCase.call();
      expect(result.length, 2);
      expect(result.first.displayName, 'Conn 1');
      expect(result.last.displayName, 'Conn 2');
    });
  });

  group('GetPinnedConnectionIdsUseCase', () {
    test('returns all pinned connection ids', () async {
      final id1 = UuidValue.fromString(const Uuid().v4());
      final id2 = UuidValue.fromString(const Uuid().v4());

      final repo = _FakePinnedConnectionRepository(initial: {id1, id2});
      final useCase = GetPinnedConnectionIdsUseCase(
        pinnedConnectionRepository: repo,
      );

      final result = await useCase.call();
      expect(result, {id1, id2});
    });
  });

  group('UnpinConnectionUseCase', () {
    test('removes connection id from pinned repository', () async {
      final id = UuidValue.fromString(const Uuid().v4());
      final repo = _FakePinnedConnectionRepository(initial: {id});
      final useCase = UnpinConnectionUseCase(pinnedConnectionRepository: repo);

      await useCase.call(connectionId: id);
      expect(repo.pinnedIds, isEmpty);
    });
  });

  group('DeleteConnectionUseCase', () {
    test('unpins and removes connection from repositories', () async {
      final id = UuidValue.fromString(const Uuid().v4());
      final conn = _buildConnection(id: id, displayName: 'To Delete');

      final connRepo = _FakeConnectionRepository(initial: [conn]);
      final pinnedRepo = _FakePinnedConnectionRepository(initial: {id});

      final useCase = DeleteConnectionUseCase(
        connectionRepository: connRepo,
        pinnedConnectionRepository: pinnedRepo,
      );

      await useCase.call(connectionId: id);

      expect(connRepo.connections, isEmpty);
      expect(pinnedRepo.pinnedIds, isEmpty);
    });
  });
}
