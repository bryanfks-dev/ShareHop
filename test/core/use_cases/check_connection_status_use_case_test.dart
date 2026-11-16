import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/core/use_cases/check_connection_status_use_case.dart';
import 'package:sharehop/data/dto/connection_credential_dto.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

class FakeAppConfigRepository implements AppConfigRepository {
  @override
  Future<String> getEncryptionKey() async => 'test-encryption-key';

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
  Future<EncryptedValue> encrypt(String text) async => EncryptedValue(
    salt: 's',
    nonce: 'n',
    cipherText: 'encrypted_$text',
    mac: 'm',
  );

  @override
  Future<String> decrypt(EncryptedValue value) async =>
      value.cipherText.replaceFirst('encrypted_', '');
}

class FakeConnectionRepository implements ConnectionRepository {
  ConnectionModel? returnModel;

  @override
  Future<ConnectionModel?> getOne(UuidValue id) async => returnModel;

  @override
  Future<ConnectionModel> create(ConnectionModel connection) =>
      throw UnimplementedError();

  @override
  Future<List<ConnectionModel>> getAll() => throw UnimplementedError();

  @override
  Future<void> remove(UuidValue id) => throw UnimplementedError();

  @override
  Future<void> batchRemove(Set<UuidValue> ids) => throw UnimplementedError();

  @override
  Future<Set<UuidValue>> checkIfExists(Set<UuidValue> ids) async => {};

  @override
  Future<ConnectionModel?> update(ConnectionModel connection) =>
      throw UnimplementedError();
}

class FakeConnectionService implements ConnectionService {
  bool shouldThrow = false;
  ConnectionCredentialDto? lastCredential;

  @override
  Future<void> verify({required ConnectionCredentialDto credential}) async {
    lastCredential = credential;
    if (shouldThrow) {
      throw Exception('Connection failed');
    }
  }
}

void main() {
  group('CheckConnectionStatusUseCase', () {
    late FakeAppConfigRepository appConfigRepo;
    late FakeConnectionRepository connectionRepo;
    late FakeConnectionService connectionService;
    late CheckConnectionStatusUseCase useCase;

    setUp(() {
      appConfigRepo = FakeAppConfigRepository();
      connectionRepo = FakeConnectionRepository();
      connectionService = FakeConnectionService();
      useCase = CheckConnectionStatusUseCase(
        connectionRepository: connectionRepo,
        appConfigRepository: appConfigRepo,
        secretCipherFactory: (_) => FakeSecretCipher(),
        connectionService: connectionService,
      );
    });

    test('returns online when verification succeeds', () async {
      final conn = ConnectionViewModel(
        id: const Uuid().v7obj(),
        displayName: 'Test Server',
        remoteAddress: 'https://example.com',
        username: 'admin',
        password: 'plain_password',
        protocol: ConnectionProtocol.webdav,
        isPinned: false,
      );

      final status = await useCase(connection: conn);

      expect(status, ConnectionStatus.online);
      expect(connectionService.lastCredential, isA<WebDavCredentialDto>());
      final cred = connectionService.lastCredential! as WebDavCredentialDto;
      expect(cred.url, Uri.parse('https://example.com'));
      expect(cred.username, 'admin');
      expect(cred.password, 'plain_password');
    });

    test('returns offline when verification throws', () async {
      connectionService.shouldThrow = true;
      final conn = ConnectionViewModel(
        id: const Uuid().v7obj(),
        displayName: 'Test Server',
        remoteAddress: 'https://example.com',
        username: 'admin',
        password: 'plain_password',
        protocol: ConnectionProtocol.webdav,
        isPinned: false,
      );

      final status = await useCase(connection: conn);

      expect(status, ConnectionStatus.offline);
    });

    test('decrypts password from connection repository if available', () async {
      final id = const Uuid().v7obj();
      final now = DateTime.now().toUtc();
      final passwordId = const Uuid().v7obj();

      connectionRepo.returnModel = ConnectionModel(
        id: id,
        protocol: ConnectionProtocol.webdav,
        displayName: 'Test',
        remoteAddress: 'https://example.com',
        username: 'admin',
        passwordId: passwordId,
        password: EncryptedValueModel(
          id: passwordId,
          salt: 'salt',
          nonce: 'nonce',
          cipherText: 'encrypted_secret_pass',
          mac: 'mac',
          createdAt: now,
          updatedAt: now,
        ),
        rootPath: '/',
        createdAt: now,
        updatedAt: now,
      );

      final conn = ConnectionViewModel(
        id: id,
        displayName: 'Test Server',
        remoteAddress: 'https://example.com',
        username: 'admin',
        password: 'encrypted_secret_pass',
        protocol: ConnectionProtocol.webdav,
        isPinned: false,
      );

      final status = await useCase(connection: conn);

      expect(status, ConnectionStatus.online);
      final cred = connectionService.lastCredential! as WebDavCredentialDto;
      expect(cred.password, 'secret_pass');
    });
  });
}
