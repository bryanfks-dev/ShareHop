import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/core/use_cases/check_connection_status_use_case.dart';
import 'package:sharehop/data/dto/connection_credential_dto.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/presentation/screens/connection_detail/screen.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_detail_header.dart';
import 'package:sharehop/presentation/screens/edit_connection/screen.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid_value.dart';

class FakeConnectionRepository implements ConnectionRepository {
  final List<UuidValue> removedIds = [];

  @override
  Future<void> remove(UuidValue id) async {
    removedIds.add(id);
  }

  @override
  Future<List<ConnectionModel>> getAll() async => [];

  @override
  Future<ConnectionModel?> getOne(UuidValue id) async => null;

  @override
  Future<ConnectionModel> create(ConnectionModel connection) async =>
      connection;

  @override
  Future<ConnectionModel?> update({
    required ConnectionRevisionDto connection,
  }) async => null;

  @override
  Future<void> batchRemove(Set<UuidValue> ids) async {}

  @override
  Future<Set<UuidValue>> checkIfExists(Set<UuidValue> ids) async => {};
}

class FakePinnedConnectionRepository implements PinnedConnectionRepository {
  final List<UuidValue> unpinnedIds = [];

  @override
  Future<void> unpin(UuidValue connectionId) async {
    unpinnedIds.add(connectionId);
  }

  @override
  Future<void> pin(UuidValue connectionId) async {}

  @override
  Future<List<PinnedConnectionModel>> getAll() async => [];

  @override
  Future<Set<UuidValue>> getPinnedConnectionIds() async => {};
}

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

class FakeConnectionService implements ConnectionService {
  bool shouldThrow = false;
  int verifyCallCount = 0;

  @override
  Future<void> verify({required ConnectionCredentialDto credential}) async {
    verifyCallCount++;
    if (shouldThrow) {
      throw Exception('Connection failed');
    }
  }
}

Widget _buildTestWidget(
  Widget child, {
  FakeConnectionRepository? connectionRepo,
  FakePinnedConnectionRepository? pinnedRepo,
  FakeConnectionService? connectionService,
  CheckConnectionStatusUseCase? checkConnectionStatusUseCase,
  AppConfigRepository? appConfigRepo,
}) {
  return ProviderScope(
    overrides: [
      appConfigRepositoryProvider
          .overrideWithValue(appConfigRepo ?? FakeAppConfigRepository()),
      connectionRepositoryProvider
          .overrideWithValue(connectionRepo ?? FakeConnectionRepository()),
      pinnedConnectionRepositoryProvider
          .overrideWithValue(pinnedRepo ?? FakePinnedConnectionRepository()),
      if (connectionService != null)
        connectionServiceProvider.overrideWithValue(connectionService),
      if (checkConnectionStatusUseCase != null)
        checkConnectionStatusUseCaseProvider
            .overrideWithValue(checkConnectionStatusUseCase),
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
    id: UuidValue.fromString('11111111-1111-1111-1111-111111111111'),
    protocol: ConnectionProtocol.webdav,
    displayName: 'Production Server',
    remoteAddress: 'https://prod.server.io',
    username: 'admin',
    password: 'password',
    isPinned: true,
    status: ConnectionStatus.online,
  );

  group('ConnectionDetailScreen', () {
    testWidgets('renders header and connection details', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(ConnectionDetailScreen(connection: testConnection)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ConnectionDetailHeader), findsOneWidget);
      expect(find.text('Production Server'), findsWidgets);
      expect(find.text('https://prod.server.io'), findsWidgets);
    });

    testWidgets('renders three horizontal dots menu button in header', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(ConnectionDetailScreen(connection: testConnection)),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(FLucideIcons.ellipsis), findsOneWidget);
    });

    testWidgets(
      'tapping three dots reveals popup menu with check, edit and '
      'delete options',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(ConnectionDetailScreen(connection: testConnection)),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(FLucideIcons.ellipsis));
        await tester.pumpAndSettle();

        expect(find.text('Check connection'), findsOneWidget);
        expect(find.text('Edit connection'), findsOneWidget);
        expect(find.text('Delete connection'), findsOneWidget);
        expect(find.byIcon(FLucideIcons.activity), findsOneWidget);
        expect(find.byIcon(FLucideIcons.pencil), findsOneWidget);
        expect(find.byIcon(FLucideIcons.trash2), findsOneWidget);
      },
    );

    testWidgets(
      'tapping Check connection invokes custom onCheckConnection callback',
      (tester) async {
        var checkCalled = false;

        await tester.pumpWidget(
          _buildTestWidget(
            ConnectionDetailScreen(
              connection: testConnection,
              onCheckConnection: () {
                checkCalled = true;
              },
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(FLucideIcons.ellipsis));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Check connection'));
        await tester.pumpAndSettle();

        expect(checkCalled, isTrue);
      },
    );

    testWidgets(
      'tapping Check connection runs status check and shows toast',
      (tester) async {
        final fakeService = FakeConnectionService();

        await tester.pumpWidget(
          _buildTestWidget(
            ConnectionDetailScreen(connection: testConnection),
            connectionService: fakeService,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(FLucideIcons.ellipsis));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Check connection'));
        await tester.pumpAndSettle();

        expect(find.text('Connection is online'), findsOneWidget);
      },
    );

    testWidgets('on first time load the connection, checks for status', (
      tester,
    ) async {
      final fakeService = FakeConnectionService();
      final freshConnection = ConnectionViewModel(
        id: UuidValue.fromString('22222222-2222-2222-2222-222222222222'),
        protocol: ConnectionProtocol.webdav,
        displayName: 'Test Server',
        remoteAddress: 'https://test.server.io',
        username: 'user',
        password: 'pwd',
        isPinned: false,
        status: ConnectionStatus.idle,
      );

      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionDetailScreen(connection: freshConnection),
          connectionService: fakeService,
        ),
      );
      await tester.pumpAndSettle();

      // Verify status was checked on first time load and updated to online
      expect(fakeService.verifyCallCount, greaterThanOrEqualTo(1));
      expect(freshConnection.status, ConnectionStatus.online);
    });

    testWidgets('tapping Edit connection invokes custom onEdit callback', (
      tester,
    ) async {
      var editCalled = false;

      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionDetailScreen(
            connection: testConnection,
            onEdit: () {
              editCalled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Edit connection'));
      await tester.pumpAndSettle();

      expect(editCalled, isTrue);
    });

    testWidgets(
      'tapping Edit connection navigates to EditConnectionScreen by default',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(ConnectionDetailScreen(connection: testConnection)),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(FLucideIcons.ellipsis));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Edit connection'));
        await tester.pumpAndSettle();

        expect(find.byType(EditConnectionScreen), findsOneWidget);
      },
    );

    testWidgets('tapping Delete connection invokes custom onDelete callback', (
      tester,
    ) async {
      var deleteCalled = false;

      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionDetailScreen(
            connection: testConnection,
            onDelete: () {
              deleteCalled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete connection'));
      await tester.pumpAndSettle();

      expect(deleteCalled, isTrue);
    });

    testWidgets(
      'tapping Delete connection opens confirmation sheet and deletes '
      'connection upon confirmation',
      (tester) async {
        final fakeConnectionRepo = FakeConnectionRepository();
        final fakePinnedRepo = FakePinnedConnectionRepository();

        await tester.pumpWidget(
          _buildTestWidget(
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ConnectionDetailScreen(
                        connection: testConnection,
                      ),
                    ),
                  );
                },
                child: const Text('Go to detail'),
              ),
            ),
            connectionRepo: fakeConnectionRepo,
            pinnedRepo: fakePinnedRepo,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Go to detail'));
        await tester.pumpAndSettle();

        // Tap three dots button
        await tester.tap(find.byIcon(FLucideIcons.ellipsis));
        await tester.pumpAndSettle();

        // Tap Delete connection item
        await tester.tap(find.text('Delete connection'));
        await tester.pumpAndSettle();

        // Confirmation sheet should be visible
        expect(find.text('Delete Connection'), findsOneWidget);
        expect(
          find.text(
            'Are you sure you want to delete "Production Server"? '
            'This connection and its credentials will be '
            'permanently removed.',
          ),
          findsOneWidget,
        );

        // Tap Delete button on confirmation sheet
        await tester.tap(find.widgetWithText(FButton, 'Delete'));
        await tester.pumpAndSettle();

        // Verify unpin and remove were invoked with connection ID
        expect(fakePinnedRepo.unpinnedIds, contains(testConnection.id));
        expect(fakeConnectionRepo.removedIds, contains(testConnection.id));

        // Verify toast and popped back to root
        expect(find.text('Connection deleted successfully'), findsOneWidget);
        expect(find.byType(ConnectionDetailScreen), findsNothing);
      },
    );
  });
}
