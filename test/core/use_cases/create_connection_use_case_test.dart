import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/data/dto/connection_credential_dto.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/data/mapper/connection_credential_mapper.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';

class FakeConnectionRepository implements ConnectionRepository {
  final List<ConnectionModel> connections = [];

  @override
  Future<ConnectionModel> create({
    required ConnectionDraftDto connection,
  }) async {
    final now = DateTime.now().toUtc();
    final model = ConnectionModel(
      id: 'test-id',
      displayName: connection.displayName,
      protocol: connection.connectionProtocol,
      remoteAddress: connection.remoteAddress,
      username: connection.username,
      passwordId: 'pwd-id',
      password: EncryptedValueModel(
        id: 'pwd-id',
        salt: '',
        cipherText: connection.password,
        nonce: '',
        mac: '',
        createdAt: now,
        updatedAt: now,
      ),
      createdAt: now,
      updatedAt: now,
    );
    connections.add(model);
    return model;
  }

  @override
  Future<List<ConnectionModel>> getAll() async => connections;

  @override
  Future<ConnectionModel?> getOne({required String id}) async =>
      connections.where((c) => c.id == id).firstOrNull;

  @override
  Future<ConnectionModel?> update({required ConnectionModel model}) async =>
      model;

  @override
  Future<void> remove({required String id}) async {
    connections.removeWhere((c) => c.id == id);
  }

  @override
  Future<void> batchRemove({required Set<String> ids}) async {
    connections.removeWhere((c) => ids.contains(c.id));
  }

  @override
  Future<String?> checkIfExists({required String id}) async =>
      connections.any((c) => c.id == id) ? id : null;
}

class FakeConnectionService implements ConnectionService {
  bool shouldThrow = false;
  ConnectionCredentialDto? verifiedCredential;

  @override
  Future<void> verify({required ConnectionCredentialDto credential}) async {
    verifiedCredential = credential;
    if (shouldThrow) {
      throw WebDavOperationFailedError(message: 'Failed to verify');
    }
  }
}

void main() {
  late FakeConnectionRepository fakeRepo;
  late FakeConnectionService fakeService;
  late ConnectionCredentialMapper credentialMapper;
  late ConnectionMapper connectionMapper;
  late CreateConnectionUseCase useCase;

  setUp(() {
    fakeRepo = FakeConnectionRepository();
    fakeService = FakeConnectionService();
    credentialMapper = ConnectionCredentialMapper();
    connectionMapper = ConnectionMapper(EncryptedValueMapper());
    useCase = CreateConnectionUseCase(
      connectionRepository: fakeRepo,
      connectionService: fakeService,
      connectionCredentialMapper: credentialMapper,
      connectionMapper: connectionMapper,
    );
  });

  group('CreateConnectionUseCase', () {
    test('creates connection after verifying credentials', () async {
      const connectionDto = ConnectionDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'example.com',
        username: 'admin',
        password: 'password',
        displayName: 'My WebDAV',
      );

      final result = await useCase.call(connection: connectionDto);

      expect(result.displayName, 'My WebDAV');
      expect(result.protocol, ConnectionProtocol.webdav);
      expect(result.remoteAddress, 'example.com');
      expect(result.username, 'admin');
      expect(fakeRepo.connections.length, 1);
      expect(fakeService.verifiedCredential, isA<WebDavCredentialDto>());
    });

    test('rethrows error when connection verification fails', () async {
      fakeService.shouldThrow = true;
      const connectionDto = ConnectionDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'example.com',
        username: 'admin',
        password: 'wrong_password',
      );

      expect(
        () => useCase.call(connection: connectionDto),
        throwsA(isA<WebDavOperationFailedError>()),
      );
      expect(fakeRepo.connections, isEmpty);
    });
  });
}
