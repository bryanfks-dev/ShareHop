import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/di/security_di.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';
import 'package:sharehop/presentation/screens/add_connection/screen.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:uuid/uuid_value.dart';

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
      throw WebDavOperationFailedError(
        message: 'Failed to connect to WebDAV server',
      );
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

Widget createTestApp({
  required FakeConnectionRepository fakeRepo,
  FakePinnedConnectionRepository? fakePinnedRepo,
  GlobalKey<NavigatorState>? navigatorKey,
  Widget? home,
}) {
  return ProviderScope(
    overrides: [
      appConfigRepositoryProvider.overrideWithValue(FakeAppConfigRepository()),
      connectionRepositoryProvider.overrideWithValue(fakeRepo),
      pinnedConnectionRepositoryProvider.overrideWithValue(
        fakePinnedRepo ?? FakePinnedConnectionRepository(),
      ),
      secretCipherFactoryProvider.overrideWithValue(
        (secret) => FakeSecretCipher(),
      ),
    ],
    child: MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
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

      final fakeRepo = FakeConnectionRepository();

      await tester.pumpWidget(createTestApp(fakeRepo: fakeRepo));
      await tester.pumpAndSettle();

      expect(find.text('Add connection'), findsOneWidget);
      expect(find.text('Display name'), findsOneWidget);
      expect(find.text('Server url'), findsOneWidget);
      expect(find.text('Root path'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password or app password'), findsOneWidget);
      expect(find.text('Save connection'), findsOneWidget);
    });

    testWidgets('shows validation errors when submitted empty', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeRepo = FakeConnectionRepository();

      await tester.pumpWidget(createTestApp(fakeRepo: fakeRepo));
      await tester.pumpAndSettle();

      final button = find.text('Save connection');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(find.text('Server url is required'), findsOneWidget);
      expect(find.text('Password or app password is required'), findsOneWidget);
      expect(fakeRepo.connections, isEmpty);
    });

    testWidgets('successfully tests and saves WebDAV connection', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeRepo = FakeConnectionRepository();
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        createTestApp(
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

      // Tap save
      final button = find.text('Save connection');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(fakeRepo.connections.length, 1);
      final created = fakeRepo.connections.first;
      expect(created.displayName, 'My Home WebDAV');
      expect(created.remoteAddress, 'https://dav.example.com/files');
      expect(created.protocol, ConnectionProtocol.webdav);
      expect(created.allowSelfSignedCertificate, isFalse);

      // Verify popped back
      expect(find.text('Previous Screen'), findsOneWidget);
    });

    testWidgets(
      'successfully saves WebDAV connection with allow self-signed certificate',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        final fakeRepo = FakeConnectionRepository();
        final navigatorKey = GlobalKey<NavigatorState>();

        await tester.pumpWidget(
          createTestApp(
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
        await tester.enterText(editables.at(0), 'Self Signed WebDAV');
        await tester.enterText(editables.at(1), 'https://selfsigned.local');
        await tester.enterText(editables.at(3), 'admin');
        await tester.enterText(editables.at(4), 'secret');
        await tester.pumpAndSettle();

        final selfSignedTile = find.text('Allow self-signed certificate');
        await tester.ensureVisible(selfSignedTile);
        await tester.tap(selfSignedTile);
        await tester.pumpAndSettle();

        final button = find.text('Save connection');
        await tester.ensureVisible(button);
        await tester.tap(button);
        await tester.pumpAndSettle();

        expect(fakeRepo.connections.length, 1);
        final created = fakeRepo.connections.first;
        expect(created.displayName, 'Self Signed WebDAV');
        expect(created.allowSelfSignedCertificate, isTrue);
      },
    );

    testWidgets('shows failure toast when connection test fails', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeRepo = FakeConnectionRepository()..shouldThrow = true;

      await tester.pumpWidget(createTestApp(fakeRepo: fakeRepo));
      await tester.pumpAndSettle();

      final editables = find.byType(EditableText);

      // Enter server URL
      await tester.enterText(editables.at(1), 'https://dav.example.com/files');

      // Enter username
      await tester.enterText(editables.at(3), 'john');

      // Enter password
      await tester.enterText(editables.at(4), 'wrong');

      await tester.pumpAndSettle();

      // Tap save
      final button = find.text('Save connection');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(fakeRepo.connections, isEmpty);
      expect(find.text('Operation failed'), findsOneWidget);
      expect(find.text('Failed to connect to WebDAV server'), findsOneWidget);
    });

    testWidgets('shows unsupported notice when another protocol is selected', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final fakeRepo = FakeConnectionRepository();

      await tester.pumpWidget(createTestApp(fakeRepo: fakeRepo));
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
