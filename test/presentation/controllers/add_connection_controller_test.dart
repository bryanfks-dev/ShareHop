import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/errors/app.dart';
import 'package:sharehop/core/errors/connection.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/di/security_di.dart';
import 'package:sharehop/presentation/controllers/add_connection_controller.dart';
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
  bool shouldThrow = false;

  @override
  Future<ConnectionModel> create(ConnectionModel connection) async {
    if (shouldThrow) {
      throw CreateConnectionFailedError();
    }
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
  }) async {
    if (shouldThrow) {
      throw UpdateConnectionFailedError();
    }
    final index = connections.indexWhere((c) => c.id.uuid == connection.id);
    if (index == -1) {
      return null;
    }
    final existing = connections[index];
    final updated = existing.copyWith(
      displayName: connection.displayName?.value ?? existing.displayName,
      remoteAddress: connection.remoteAddress?.value ?? existing.remoteAddress,
      rootPath: connection.rootPath?.value ?? existing.rootPath,
      username: connection.username?.value ?? existing.username,
    );
    connections[index] = updated;
    return updated;
  }

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
  final Set<UuidValue> pinnedIds = {};

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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeAppConfigRepository fakeAppConfigRepo;
  late FakeConnectionRepository fakeRepo;
  late FakePinnedConnectionRepository fakePinnedRepo;
  late ProviderContainer container;

  setUp(() {
    fakeAppConfigRepo = FakeAppConfigRepository();
    fakeRepo = FakeConnectionRepository();
    fakePinnedRepo = FakePinnedConnectionRepository();
    container = ProviderContainer(
      overrides: [
        appConfigRepositoryProvider.overrideWithValue(fakeAppConfigRepo),
        connectionRepositoryProvider.overrideWithValue(fakeRepo),
        pinnedConnectionRepositoryProvider.overrideWithValue(fakePinnedRepo),
        secretCipherFactoryProvider.overrideWithValue(
          (secret) => FakeSecretCipher(),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AddConnectionController', () {
    test('initial state is AsyncData(null)', () {
      final state = container.read(addConnectionControllerProvider);
      expect(state.value, isNull);
    });

    test(
      'addWebDavConnection adds connection and updates state on success',
      () async {
        final controller = container.read(
          addConnectionControllerProvider.notifier,
        );

        final result = await controller.addWebDavConnection(
          remoteAddress: 'https://dav.example.com',
          rootPath: '/',
          username: 'admin',
          password: 'pwd',
          displayName: 'My WebDAV',
        );

        expect(result.displayName, 'My WebDAV');
        expect(result.protocol, ConnectionProtocol.webdav);
        expect(result.remoteAddress, 'https://dav.example.com');
        expect(result.isPinned, isTrue);
        expect(container.read(addConnectionControllerProvider).value, result);
        expect(fakeRepo.connections.length, 1);
        expect(fakePinnedRepo.pinnedIds, contains(result.id));
      },
    );

    test(
      'addWebDavConnection does not pin when pinned limit is reached',
      () async {
        final controller = container.read(
          addConnectionControllerProvider.notifier,
        );

        for (var i = 0; i < 6; i++) {
          fakePinnedRepo.pinnedIds.add(UuidValue.fromString(const Uuid().v4()));
        }

        final result = await controller.addWebDavConnection(
          remoteAddress: 'https://dav.example.com',
          rootPath: '/',
          username: 'admin',
          password: 'pwd',
          displayName: 'Not Pinned WebDAV',
        );

        expect(result.isPinned, isFalse);
        expect(fakePinnedRepo.pinnedIds, isNot(contains(result.id)));
      },
    );

    test(
      'addWebDavConnection sets AsyncError and rethrows on failure',
      () async {
        fakeRepo.shouldThrow = true;
        final controller = container.read(
          addConnectionControllerProvider.notifier,
        );

        expect(
          () => controller.addWebDavConnection(
            remoteAddress: 'https://dav.example.com',
            rootPath: '/',
            username: 'admin',
            password: 'pwd',
          ),
          throwsA(isA<AppError>()),
        );

        expect(fakeRepo.connections, isEmpty);
      },
    );

    test(
      'updateWebDavConnection updates connection and state on success',
      () async {
        final controller = container.read(
          addConnectionControllerProvider.notifier,
        );

        final initial = await controller.addWebDavConnection(
          remoteAddress: 'https://dav.example.com',
          rootPath: '/',
          username: 'admin',
          password: 'pwd',
          displayName: 'Initial',
        );

        final updated = await controller.updateWebDavConnection(
          id: initial.id,
          remoteAddress: 'https://dav-updated.example.com',
          rootPath: '/files',
          username: 'newadmin',
          password: 'newpwd',
          displayName: 'Updated WebDAV',
          isPinned: true,
        );

        expect(updated.displayName, 'Updated WebDAV');
        expect(updated.remoteAddress, 'https://dav-updated.example.com');
        expect(updated.rootPath, '/files');
        expect(updated.username, 'newadmin');
        expect(container.read(addConnectionControllerProvider).value, updated);
      },
    );

    test(
      'updateWebDavConnection sets AsyncError and rethrows on failure',
      () async {
        final controller = container.read(
          addConnectionControllerProvider.notifier,
        );

        final initial = await controller.addWebDavConnection(
          remoteAddress: 'https://dav.example.com',
          rootPath: '/',
          username: 'admin',
          password: 'pwd',
          displayName: 'Initial',
        );

        fakeRepo.shouldThrow = true;

        expect(
          () => controller.updateWebDavConnection(
            id: initial.id,
            remoteAddress: 'https://dav-updated.example.com',
            rootPath: '/files',
            username: 'newadmin',
            password: 'newpwd',
          ),
          throwsA(isA<AppError>()),
        );
      },
    );
  });
}
