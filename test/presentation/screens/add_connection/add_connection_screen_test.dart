import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/data/dto/storage_status_dto.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:sharehop/core/repositories/connection/repository.dart';
import 'package:sharehop/core/gateways/web_dav_storage_gateway.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/core/use_cases/test_connection_use_case.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/infrastructures/repositories/connection/factory.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';
import 'package:sharehop/presentation/screens/add_connection/screen.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:webdav_client/webdav_client.dart';

class FakeWebDavStorageGateway implements WebDavStorageGateway {
  bool shouldThrow = false;
  WebDavCredentialModel? passedCredential;

  @override
  Future<void> testConnection({
    required WebDavCredentialModel credential,
  }) async {
    passedCredential = credential;
    if (shouldThrow) {
      throw WebDavOperationFailedError('Failed to connect to WebDAV server');
    }
  }

  @override
  Future<List<File>> list({
    required WebDavCredentialModel credential,
    required String path,
  }) async =>
      [];

  @override
  Future<void> createDirectory({
    required WebDavCredentialModel credential,
    required String path,
  }) async {}

  @override
  Future<void> delete({
    required WebDavCredentialModel credential,
    required String path,
  }) async {}

  @override
  Future<void> uploadFile({
    required WebDavCredentialModel credential,
    required String path,
    required Uint8List fileBytes,
  }) async {}

  @override
  Future<Uint8List> downloadFile({
    required WebDavCredentialModel credential,
    required String path,
  }) async =>
      Uint8List(0);

  @override
  Future<void> rename({
    required WebDavCredentialModel credential,
    required String oldPath,
    required String newPath,
  }) async {}

  @override
  Future<void> copy({
    required WebDavCredentialModel credential,
    required String sourcePath,
    required String destinationPath,
  }) async {}

  @override
  Future<void> move({
    required WebDavCredentialModel credential,
    required String sourcePath,
    required String destinationPath,
  }) async {}

  @override
  Future<File> getFileProperties({
    required WebDavCredentialModel credential,
    required String path,
  }) async =>
      throw UnimplementedError();

  @override
  Future<StorageStatusDto> getStatus({
    required WebDavCredentialModel credential,
    String path = '/',
  }) async =>
      const StorageStatusDto(
        totalBytes: 500 * 1024 * 1024 * 1024,
        freeBytes: 64 * 1024 * 1024 * 1024,
      );
}

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
  Future<ConnectionModel?> getOne(String id) async => null;

  @override
  Future<ConnectionModel?> update(ConnectionRevisionDto revision) async => null;

  @override
  Future<void> remove(String id) async {}

  @override
  Future<void> batchRemove(Set<String> ids) async {}

  @override
  Future<String?> checkIfExists(String id) async => null;
}

Widget createTestApp({
  required FakeWebDavStorageGateway fakeService,
  required FakeConnectionRepository fakeRepo,
  GlobalKey<NavigatorState>? navigatorKey,
  Widget? home,
}) {
  return ProviderScope(
    overrides: [
      testConnectionUseCaseProvider.overrideWithValue(
        TestConnectionUseCase(fakeService),
      ),
      createConnectionUseCaseProvider.overrideWithValue(
        CreateConnectionUseCase(fakeRepo),
      ),
    ],
    child: MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) => FTheme(
        data: darkTheme,
        child: FToaster(
          child: FTooltipGroup(
            child: child!,
          ),
        ),
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

      final fakeService = FakeWebDavStorageGateway();
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

      final fakeService = FakeWebDavStorageGateway();
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

    testWidgets('successfully tests and saves WebDAV connection',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeService = FakeWebDavStorageGateway();
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

      // EditableTexts in order:
      // 0: Display name
      // 1: Server url
      // 2: Root path ('/')
      // 3: Username
      // 4: Password
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

    testWidgets('shows failure toast when connection test fails',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeService = FakeWebDavStorageGateway()..shouldThrow = true;
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
      expect(
        find.text('Failed to connect to WebDAV server'),
        findsOneWidget,
      );
    });

    testWidgets('shows unsupported notice when another protocol is selected',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeService = FakeWebDavStorageGateway();
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
