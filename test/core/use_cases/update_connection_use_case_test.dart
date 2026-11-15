import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/errors/connection.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/core/use_cases/update_connection_use_case.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';
import 'package:uuid/uuid.dart';

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
  ConnectionRevisionDto? lastRevision;
  ConnectionModel? returnModel;

  @override
  Future<ConnectionModel> create(ConnectionModel connection) =>
      throw UnimplementedError();

  @override
  Future<List<ConnectionModel>> getAll() async => [];

  @override
  Future<ConnectionModel?> getOne(UuidValue id) async => returnModel;

  @override
  Future<ConnectionModel?> update({
    required ConnectionRevisionDto connection,
  }) async {
    lastRevision = connection;
    return returnModel;
  }

  @override
  Future<void> remove(UuidValue id) async {}

  @override
  Future<void> batchRemove(Set<UuidValue> ids) async {}

  @override
  Future<Set<UuidValue>> checkIfExists(Set<UuidValue> ids) async => {};
}

void main() {
  late FakeAppConfigRepository appConfigRepository;
  late FakeConnectionRepository connectionRepository;
  late FakeSecretCipher secretCipher;
  late UpdateConnectionUseCase useCase;

  final testId = const Uuid().v7obj();
  final now = DateTime.now().toUtc();
  final testModel = ConnectionModel(
    id: testId,
    protocol: ConnectionProtocol.webdav,
    displayName: 'Updated Server',
    remoteAddress: 'https://new.server.io',
    username: 'newuser',
    passwordId: const Uuid().v7obj(),
    password: EncryptedValueModel(
      id: const Uuid().v7obj(),
      salt: 'salt-1',
      nonce: 'nonce-1',
      cipherText: 'encrypted-newpass',
      mac: 'mac-1',
      createdAt: now,
      updatedAt: now,
    ),
    rootPath: '/newpath',
    createdAt: now,
    updatedAt: now,
  );

  setUp(() {
    appConfigRepository = FakeAppConfigRepository();
    connectionRepository = FakeConnectionRepository();
    secretCipher = FakeSecretCipher();
    useCase = UpdateConnectionUseCase(
      appConfigRepository: appConfigRepository,
      connectionRepository: connectionRepository,
      secretCipherFactory: (key) => secretCipher,
    );
  });

  group('UpdateConnectionUseCase', () {
    test('successfully updates connection with encrypted password', () async {
      connectionRepository.returnModel = testModel;

      final result = await useCase.call(
        id: testId,
        displayName: 'Updated Server',
        remoteAddress: 'https://new.server.io',
        rootPath: '/newpath',
        username: 'newuser',
        password: 'newpass',
      );

      expect(result, testModel);
      expect(connectionRepository.lastRevision, isNotNull);
      expect(connectionRepository.lastRevision!.id, testId.uuid);
      expect(
        connectionRepository.lastRevision!.displayName?.value,
        'Updated Server',
      );
      expect(
        connectionRepository.lastRevision!.remoteAddress?.value,
        'https://new.server.io',
      );
      expect(
        connectionRepository.lastRevision!.username?.value,
        'newuser',
      );
      expect(
        connectionRepository.lastRevision!.rootPath?.value,
        '/newpath',
      );
      expect(
        connectionRepository.lastRevision!.password?.value,
        'encrypted-newpass',
      );
    });

    test('throws UpdateConnectionFailedError when repository returns null', () {
      connectionRepository.returnModel = null;

      expect(
        () => useCase.call(
          id: testId,
          remoteAddress: 'https://new.server.io',
          rootPath: '/newpath',
          username: 'newuser',
          password: 'newpass',
        ),
        throwsA(isA<UpdateConnectionFailedError>()),
      );
    });
  });
}
