import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/data/dto/connection_credential_dto.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';
import 'package:sharehop/presentation/controllers/add_connection_controller.dart';

class FakeConnectionService implements ConnectionService {
  bool shouldThrow = false;

  @override
  Future<void> verify({required ConnectionCredentialDto credential}) async {
    if (shouldThrow) {
      throw WebDavOperationFailedError(message: 'Verification failed');
    }
  }
}

class FakeConnectionRepository implements ConnectionRepository {
  final List<ConnectionModel> connections = [];

  @override
  Future<ConnectionModel> create({
    required ConnectionDraftDto connection,
  }) async {
    final now = DateTime.now().toUtc();
    final model = ConnectionModel(
      id: 'conn-1',
      displayName: connection.displayName,
      protocol: connection.connectionProtocol,
      remoteAddress: connection.remoteAddress,
      username: connection.username,
      passwordId: 'pwd-1',
      password: EncryptedValueModel(
        id: 'pwd-1',
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
  Future<ConnectionModel?> getOne({required String id}) async => null;

  @override
  Future<ConnectionModel?> update({required ConnectionModel model}) async =>
      null;

  @override
  Future<void> remove({required String id}) async {}

  @override
  Future<void> batchRemove({required Set<String> ids}) async {}

  @override
  Future<String?> checkIfExists({required String id}) async => null;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeConnectionService fakeService;
  late FakeConnectionRepository fakeRepo;
  late ProviderContainer container;

  setUp(() {
    fakeService = FakeConnectionService();
    fakeRepo = FakeConnectionRepository();
    container = ProviderContainer(
      overrides: [
        connectionServiceProvider.overrideWithValue(fakeService),
        connectionRepositoryProvider.overrideWithValue(fakeRepo),
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
        expect(container.read(addConnectionControllerProvider).value, result);
        expect(fakeRepo.connections.length, 1);
      },
    );

    test(
      'addWebDavConnection sets AsyncError and rethrows on failure',
      () async {
        fakeService.shouldThrow = true;
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
          throwsA(isA<WebDavOperationFailedError>()),
        );

        expect(fakeRepo.connections, isEmpty);
      },
    );
  });
}
