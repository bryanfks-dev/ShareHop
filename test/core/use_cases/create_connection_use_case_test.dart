import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:sharehop/core/repositories/connection/repository.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/infrastructures/repositories/connection/factory.dart';

class FakeConnectionRepository implements ConnectionRepository {
  final List<ConnectionModel> connections = [];

  @override
  Future<ConnectionModel> create(ConnectionDraftDto draft) async {
    final model = buildConnectionDraftDtoFromConnectionModel(draft);
    connections.add(model);
    return model;
  }

  @override
  Future<List<ConnectionModel>> getAll() async => connections;

  @override
  Future<ConnectionModel?> getOne(String id) async {
    for (final connection in connections) {
      if (connection.id == id) {
        return connection;
      }
    }
    return null;
  }

  @override
  Future<ConnectionModel?> update(ConnectionRevisionDto revision) async => null;

  @override
  Future<void> remove(String id) async {
    connections.removeWhere((c) => c.id == id);
  }

  @override
  Future<void> batchRemove(Set<String> ids) async {
    connections.removeWhere((c) => ids.contains(c.id));
  }

  @override
  Future<String?> checkIfExists(String id) async =>
      connections.any((c) => c.id == id) ? id : null;
}

void main() {
  group('CreateConnectionUseCase', () {
    test('creates and persists connection from draft', () async {
      final fakeRepo = FakeConnectionRepository();
      final useCase = CreateConnectionUseCase(fakeRepo);

      const draft = ConnectionDraftDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://example.com/dav',
        displayName: 'My WebDAV',
      );

      final result = await useCase.call(draft: draft);

      expect(result.displayName, 'My WebDAV');
      expect(result.protocol, ConnectionProtocol.webdav);
      expect(result.remoteAddress, 'https://example.com/dav');
      expect(fakeRepo.connections.length, 1);
      expect(fakeRepo.connections.first.id, result.id);
    });
  });
}
