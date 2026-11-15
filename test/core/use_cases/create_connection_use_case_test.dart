import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/factories/connection/factory.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';
import 'package:uuid/uuid_value.dart';

class FakeAppConfigRepository implements AppConfigRepository {
  bool shouldThrow = false;

  @override
  Future<String> getEncryptionKey() async {
    if (shouldThrow) {
      throw Exception('Key retrieval failed');
    }
    return 'test-encryption-key';
  }

  @override
  Future<AppConfigModel> getConfig() => throw UnimplementedError();

  @override
  Future<void> setAppTheme({required dynamic theme}) =>
      throw UnimplementedError();

  @override
  Future<void> setBackgroundTransfersEnabled({required bool enabled}) =>
      throw UnimplementedError();

  @override
  Future<void> setBiometricLockEnabled({required bool enabled}) =>
      throw UnimplementedError();

  @override
  Future<void> setDownloadPath({required String path}) =>
      throw UnimplementedError();

  @override
  Future<void> setFileConflictResolution({required dynamic resolution}) =>
      throw UnimplementedError();

  @override
  Future<void> setMaxSimultaneousTransfers({required int limit}) =>
      throw UnimplementedError();

  @override
  Future<void> setWifiOnlyTransfersEnabled({required bool enabled}) =>
      throw UnimplementedError();
}

class FakeSecretCipher implements SecretCipher {
  @override
  Future<EncryptedValue> encrypt(String text) async {
    return EncryptedValue(
      salt: 'salt-1',
      nonce: 'nonce-1',
      cipherText: 'encrypted-$text',
      mac: 'mac-1',
    );
  }

  @override
  Future<String> decrypt(EncryptedValue value) async {
    return value.cipherText.replaceAll('encrypted-', '');
  }
}

class FakeConnectionRepository implements ConnectionRepository {
  final List<ConnectionModel> connections = [];

  @override
  Future<ConnectionModel> create(ConnectionModel connection) async {
    connections.add(connection);
    return connection;
  }

  @override
  Future<List<ConnectionModel>> getAll() async => connections;

  @override
  Future<ConnectionModel?> getOne(UuidValue id) async =>
      connections.where((c) => c.id == id).firstOrNull;

  @override
  Future<ConnectionModel?> update({
    required ConnectionRevisionDto connection,
  }) async => null;

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

void main() {
  late FakeAppConfigRepository fakeAppConfigRepo;
  late FakeConnectionRepository fakeConnectionRepo;
  late ConnectionFactory connectionFactory;
  late CreateConnectionUseCase useCase;

  setUp(() {
    fakeAppConfigRepo = FakeAppConfigRepository();
    fakeConnectionRepo = FakeConnectionRepository();
    connectionFactory = const ConnectionFactory();
    useCase = CreateConnectionUseCase(
      appConfigRepository: fakeAppConfigRepo,
      connectionRepository: fakeConnectionRepo,
      secretCipherFactory: (secret) => FakeSecretCipher(),
      connectionFactory: connectionFactory,
    );
  });

  group('CreateConnectionUseCase', () {
    test('creates and persists connection with encrypted password', () async {
      const connectionDto = ConnectionDto(
        protocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://example.com',
        username: 'admin',
        password: 'password123',
        displayName: 'My WebDAV',
        rootPath: '/remote.php/webdav',
      );

      final result = await useCase.call(connection: connectionDto);

      expect(result.displayName, 'My WebDAV');
      expect(result.protocol, ConnectionProtocol.webdav);
      expect(result.remoteAddress, 'https://example.com');
      expect(result.username, 'admin');
      expect(result.rootPath, '/remote.php/webdav');
      expect(result.password?.cipherText, 'encrypted-password123');
      expect(fakeConnectionRepo.connections.length, 1);
      expect(fakeConnectionRepo.connections.first.id, result.id);
    });

    test('rethrows error when encryption key retrieval fails', () async {
      fakeAppConfigRepo.shouldThrow = true;
      const connectionDto = ConnectionDto(
        protocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://example.com',
        username: 'admin',
        password: 'password123',
      );

      expect(
        () => useCase.call(connection: connectionDto),
        throwsA(isA<Exception>()),
      );
      expect(fakeConnectionRepo.connections, isEmpty);
    });
  });
}
