import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/data/dto/connection_credential_dto.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';
import 'package:sharehop/presentation/screens/add_connection/screen.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class FakeConnectionService implements ConnectionService {
  bool shouldThrow = false;
  WebDavCredentialDto? passedCredential;

  @override
  Future<void> verify({required ConnectionCredentialDto credential}) async {
    if (credential is WebDavCredentialDto) {
      passedCredential = credential;
    }
    if (shouldThrow) {
      throw WebDavOperationFailedError(
        message: 'Failed to connect to WebDAV server',
      );
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

Widget createTestApp({
  required FakeConnectionService fakeService,
  required FakeConnectionRepository fakeRepo,
  GlobalKey<NavigatorState>? navigatorKey,
  Widget? home,
}) {
  return ProviderScope(
    overrides: [
      connectionServiceProvider.overrideWithValue(fakeService),
      connectionRepositoryProvider.overrideWithValue(fakeRepo),
    ],
    child: MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) => FTheme(
        data: darkTheme,
        child: FToaster(child: FTooltipGroup(child: child!)),
      ),
      home: home ?? const AddConnectionScreen(),
    ),
  );
}

void main() {
  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  group('AddConnectionScreen', () {
    testWidgets('renders all initial fields for WebDAV', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeService = FakeConnectionService();
      final fakeRepo = FakeConnectionRepository();

      await tester.pumpWidget(
        createTestApp(fakeService: fakeService, fakeRepo: fakeRepo),
      );
      await tester.pumpAndSettle();

      expect(find.text('Add connection'), findsOneWidget);
      expect(find.text('Display name'), findsOneWidget);
      expect(find.text('Server url'), findsOneWidget);
      expect(find.text('Root path'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password or app password'), findsOneWidget);
      expect(find.text('Test & save connection'), findsOneWidget);
    });

    testWidgets('shows validation errors when submitted empty', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeService = FakeConnectionService();
      final fakeRepo = FakeConnectionRepository();

      await tester.pumpWidget(
        createTestApp(fakeService: fakeService, fakeRepo: fakeRepo),
      );
      await tester.pumpAndSettle();

      final button = find.text('Test & save connection');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(find.text('Server url is required'), findsOneWidget);
      expect(find.text('Username is required'), findsOneWidget);
      expect(find.text('Password or app password is required'), findsOneWidget);
      expect(fakeRepo.connections, isEmpty);
    });

    testWidgets('successfully tests and saves WebDAV connection', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeService = FakeConnectionService();
      final fakeRepo = FakeConnectionRepository();
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        createTestApp(
          fakeService: fakeService,
          fakeRepo: fakeRepo,
          navigatorKey: navigatorKey,
          home: const Scaffold(body: Text('Previous Screen')),
        ),
      );
      await tester.pumpAndSettle();

      navigatorKey.currentState!.push(
        MaterialPageRoute<void>(builder: (_) => const AddConnectionScreen()),
      );
      await tester.pumpAndSettle();

      final editables = find.byType(EditableText);
      expect(editables, findsNWidgets(5));

      // Enter display name
      await tester.enterText(editables.at(0), 'My Home WebDAV');

      // Enter server URL
      await tester.enterText(editables.at(1), 'https://dav.example.com/files');

      // Enter username
      await tester.enterText(editables.at(3), 'john');

      // Enter password
      await tester.enterText(editables.at(4), 'secret123');

      await tester.pumpAndSettle();

      // Tap test & save
      final button = find.text('Test & save connection');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(fakeRepo.connections.length, 1);
      final created = fakeRepo.connections.first;
      expect(created.displayName, 'My Home WebDAV');
      expect(created.remoteAddress, 'https://dav.example.com/files');
      expect(created.protocol, ConnectionProtocol.webdav);
      expect(
        fakeService.passedCredential?.url,
        Uri.parse('https://dav.example.com/files'),
      );
      expect(fakeService.passedCredential?.username, 'john');
      expect(fakeService.passedCredential?.password, 'secret123');

      // Verify popped back and success toast appears
      expect(find.text('Previous Screen'), findsOneWidget);
      expect(find.text('Connection saved successfully'), findsOneWidget);
    });

    testWidgets('shows failure toast when connection test fails', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeService = FakeConnectionService()..shouldThrow = true;
      final fakeRepo = FakeConnectionRepository();

      await tester.pumpWidget(
        createTestApp(fakeService: fakeService, fakeRepo: fakeRepo),
      );
      await tester.pumpAndSettle();

      final editables = find.byType(EditableText);

      // Enter server URL
      await tester.enterText(editables.at(1), 'https://dav.example.com/files');

      // Enter username
      await tester.enterText(editables.at(3), 'john');

      // Enter password
      await tester.enterText(editables.at(4), 'wrong');

      await tester.pumpAndSettle();

      // Tap test & save
      final button = find.text('Test & save connection');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(fakeRepo.connections, isEmpty);
      expect(find.text('Connection failed'), findsOneWidget);
      expect(find.text('Failed to connect to WebDAV server'), findsOneWidget);
    });

    testWidgets('shows unsupported notice when another protocol is selected', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeService = FakeConnectionService();
      final fakeRepo = FakeConnectionRepository();

      await tester.pumpWidget(
        createTestApp(fakeService: fakeService, fakeRepo: fakeRepo),
      );
      await tester.pumpAndSettle();

      // Tap Change button on protocol selector
      await tester.tap(find.text('Change'));
      await tester.pumpAndSettle();

      // Tap SMB in the sheet
      await tester.tap(find.text('SMB'));
      await tester.pumpAndSettle();

      expect(find.text('SMB is not supported yet'), findsOneWidget);
      expect(
        find.text(
          'Currently only WebDAV protocol is supported. '
          'Please select WebDAV to configure your connection.',
        ),
        findsOneWidget,
      );
    });
  });
}
