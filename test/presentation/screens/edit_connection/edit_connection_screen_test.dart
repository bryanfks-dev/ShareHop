import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/di/security_di.dart';
import 'package:sharehop/presentation/screens/edit_connection/screen.dart';
import 'package:sharehop/presentation/theme/theme.dart';
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
  ConnectionModel? lastUpdatedConnection;

  @override
  Future<ConnectionModel> create(ConnectionModel connection) =>
      throw UnimplementedError();

  @override
  Future<List<ConnectionModel>> getAll() async => [];

  @override
  Future<ConnectionModel?> getOne(UuidValue id) async {
    final now = DateTime.now().toUtc();
    return ConnectionModel(
      id: id,
      protocol: ConnectionProtocol.webdav,
      displayName: 'My WebDAV Server',
      remoteAddress: 'https://webdav.myhost.com',
      username: 'john_doe',
      passwordId: const Uuid().v7obj(),
      rootPath: '/remote.php/webdav',
      createdAt: now,
      updatedAt: now,
    );
  }

  @override
  Future<ConnectionModel?> update(ConnectionModel connection) async {
    lastUpdatedConnection = connection;
    return connection;
  }

  @override
  Future<void> remove(UuidValue id) async {}

  @override
  Future<void> batchRemove(Set<UuidValue> ids) async {}

  @override
  Future<Set<UuidValue>> checkIfExists(Set<UuidValue> ids) async => {};
}

Widget _buildTestWidget(Widget child, {FakeConnectionRepository? repo}) {
  return ProviderScope(
    overrides: [
      appConfigRepositoryProvider.overrideWithValue(FakeAppConfigRepository()),
      connectionRepositoryProvider.overrideWithValue(
        repo ?? FakeConnectionRepository(),
      ),
      secretCipherFactoryProvider.overrideWithValue(
        (secret) => FakeSecretCipher(),
      ),
    ],
    child: MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: child,
    ),
  );
}

void main() {
  final testConnection = ConnectionViewModel(
    id: const Uuid().v7obj(),
    protocol: ConnectionProtocol.webdav,
    displayName: 'My WebDAV Server',
    remoteAddress: 'https://webdav.myhost.com',
    username: 'john_doe',
    password: 'supersecretpassword',
    rootPath: '/remote.php/webdav',
    isPinned: false,
  );

  group('EditConnectionScreen', () {
    testWidgets('pre-populates form fields with existing connection data', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(EditConnectionScreen(connection: testConnection)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Edit connection'), findsOneWidget);
      expect(find.text('My WebDAV Server'), findsWidgets);
      expect(find.text('https://'), findsWidgets);
      expect(find.text('webdav.myhost.com'), findsOneWidget);
      expect(find.text('john_doe'), findsOneWidget);
      expect(find.text('/remote.php/webdav'), findsOneWidget);
      expect(find.text('supersecretpassword'), findsOneWidget);
    });

    testWidgets('updates connection when save is pressed', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final fakeRepo = FakeConnectionRepository();

      await tester.pumpWidget(
        _buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        EditConnectionScreen(connection: testConnection),
                  ),
                );
              },
              child: const Text('Go to edit'),
            ),
          ),
          repo: fakeRepo,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Go to edit'));
      await tester.pumpAndSettle();

      // Clear and enter new display name
      final displayNameField = find.widgetWithText(
        FTextFormField,
        'Display name',
      );
      await tester.enterText(displayNameField, 'Renamed Server');

      // Scroll to and tap test and save
      final saveButton = find.text('Save connection');
      await tester.ensureVisible(saveButton);
      await tester.pumpAndSettle();
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(fakeRepo.lastUpdatedConnection, isNotNull);
      expect(fakeRepo.lastUpdatedConnection!.id, testConnection.id);
      expect(fakeRepo.lastUpdatedConnection!.displayName, 'Renamed Server');
      expect(find.byType(EditConnectionScreen), findsNothing);
    });
  });
}
