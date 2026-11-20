import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_lucide/forui_lucide.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/overlays/share/overlay.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/application_overlay.dart';
import 'package:uuid/uuid.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const testChannel = MethodChannel('share_channel');

  Widget buildTestWidget({
    List<dynamic> overrides = const [],
    MethodChannel channel = testChannel,
  }) {
    return ProviderScope(
      overrides: overrides.cast(),
      child: ApplicationOverlay(child: ShareOverlay(channel: channel)),
    );
  }

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(testChannel, null);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(testChannel, null);
  });

  group('ShareOverlay', () {
    testWidgets('renders fallback/default view when no data from channel', (
      tester,
    ) async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(testChannel, (call) async {
            if (call.method == 'getSharedData') {
              return null;
            }
            return null;
          });

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Transfer with ShareHop'), findsOneWidget);
      expect(find.text('Campaign selects'), findsOneWidget);
      expect(find.text('Upload 3 files'), findsOneWidget);
    });

    testWidgets('loads shared data from MethodChannel and displays it', (
      tester,
    ) async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(testChannel, (call) async {
            if (call.method == 'getSharedData') {
              return {
                'uris': ['content://media/external/images/media/42'],
                'files': [
                  {
                    'name': 'vacation.jpg',
                    'size': 1048576,
                    'mimeType': 'image/jpeg',
                    'uri': 'content://media/external/images/media/42',
                  },
                ],
                'totalBytes': 1048576,
                'text': null,
              };
            }
            return null;
          });

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Transfer with ShareHop'), findsOneWidget);
      expect(find.text('1 file(s) selected (1.0 MB)'), findsOneWidget);
      expect(find.text('vacation.jpg'), findsOneWidget);
      expect(find.text('1.0 MB · image/jpeg'), findsOneWidget);
      expect(find.text('Upload 1 files'), findsOneWidget);
    });

    testWidgets('triggers close when sheet is dismissed', (tester) async {
      var isCloseCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(testChannel, (call) async {
            if (call.method == 'close') {
              isCloseCalled = true;
              return null;
            }
            return null;
          });

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(isCloseCalled, isTrue);
    });

    testWidgets('triggers openApp when Add Connection open is pressed', (
      tester,
    ) async {
      var isOpenAppCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(testChannel, (call) async {
            if (call.method == 'openApp') {
              isOpenAppCalled = true;
              return null;
            }
            return null;
          });

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Open'));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(isOpenAppCalled, isTrue);
    });

    testWidgets('displays connection from ManagePinnedConnectionsController', (
      tester,
    ) async {
      final customConnection = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.webdav,
        displayName: 'My WebDAV Server',
        remoteAddress: 'https://dav.example.com',
        username: 'user',
        password: 'password',
        isPinned: true,
        rootPath: '/remote/files',
        status: ConnectionStatus.online,
      );

      await tester.pumpWidget(
        buildTestWidget(
          overrides: [
            managePinnedConnectionsControllerProvider.overrideWith(
              () => _TestManagePinnedConnectionsController(
                state: ManagePinnedConnectionsState(
                  pinnedConnections: [customConnection],
                  otherConnections: [],
                ),
              ),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('My WebDAV Server'), findsOneWidget);
      expect(find.text('https://dav.example.com'), findsOneWidget);
      expect(find.text('/remote/files'), findsOneWidget);
      expect(find.text('Add new connection'), findsNothing);
    });

    testWidgets('allows selecting another destination connection', (
      tester,
    ) async {
      final conn1 = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.sftp,
        displayName: 'Server One',
        remoteAddress: 'sftp1.example.com',
        username: 'user',
        password: 'password',
        isPinned: true,
        rootPath: '/home/user',
        status: ConnectionStatus.online,
      );
      final conn2 = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.webdav,
        displayName: 'Server Two',
        remoteAddress: 'https://sftp2.example.com',
        username: 'user2',
        password: 'password',
        isPinned: false,
        rootPath: '/webdav/root',
        status: ConnectionStatus.online,
      );

      await tester.pumpWidget(
        buildTestWidget(
          overrides: [
            managePinnedConnectionsControllerProvider.overrideWith(
              () => _TestManagePinnedConnectionsController(
                state: ManagePinnedConnectionsState(
                  pinnedConnections: [conn1],
                  otherConnections: [conn2],
                ),
              ),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Server One'), findsOneWidget);

      // Tap on destination card to open picker
      await tester.tap(find.text('Server One'));
      await tester.pumpAndSettle();

      expect(find.text('Select Destination'), findsOneWidget);
      expect(find.text('Server Two'), findsWidgets);

      // Select Server Two
      await tester.tap(find.text('Server Two').last);
      await tester.pumpAndSettle();

      expect(find.text('Server Two'), findsOneWidget);
      expect(find.text('/webdav/root'), findsOneWidget);
    });

    testWidgets('allows browsing and confirming new destination path', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Browse'));
      await tester.pumpAndSettle();

      expect(find.text('Destination Path'), findsOneWidget);
      expect(find.text('Confirm path'), findsOneWidget);

      await tester.enterText(find.byType(EditableText), '/custom/path');
      await tester.tap(find.text('Confirm path'));
      await tester.pumpAndSettle();

      expect(find.text('/custom/path'), findsOneWidget);
    });

    testWidgets('tapping Upload triggers close', (tester) async {
      var isCloseCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(testChannel, (call) async {
            if (call.method == 'close') {
              isCloseCalled = true;
              return null;
            }
            return null;
          });

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Upload 3 files'));
      await tester.tap(find.text('Upload 3 files'));
      await tester.pumpAndSettle();

      expect(isCloseCalled, isTrue);
    });

    testWidgets('allows viewing and excluding files when clicking image', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Upload 3 files'), findsOneWidget);

      await tester.tap(find.byIcon(FLucideIcons.image));
      await tester.pumpAndSettle();

      expect(find.text('Selected Files'), findsOneWidget);
      expect(find.text('3 file(s) selected'), findsOneWidget);

      // Exclude the first file
      await tester.tap(find.byIcon(FLucideIcons.x).first);
      await tester.pumpAndSettle();

      expect(find.text('2 file(s) selected'), findsOneWidget);
      expect(find.text('Excluded (1)'), findsOneWidget);

      // Close the sheet
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Main sheet is updated
      expect(find.text('Upload 2 files'), findsOneWidget);
    });

    testWidgets('allows changing simultaneous transfers limit locally', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Simultaneous transfers'), findsOneWidget);
      expect(find.text('3 transfers'), findsOneWidget);

      await tester.ensureVisible(find.text('Simultaneous transfers'));
      await tester.tap(find.text('Simultaneous transfers'));
      await tester.pumpAndSettle();

      expect(find.text('Select simultaneous transfers limit'), findsOneWidget);

      await tester.tap(find.text('5 transfer(s)'));
      await tester.pumpAndSettle();

      expect(find.text('5 transfers'), findsOneWidget);
    });
  });
}

class _TestManagePinnedConnectionsController
    extends ManagePinnedConnectionsController {
  new({required ManagePinnedConnectionsState state}) : _initialState = state;

  final ManagePinnedConnectionsState _initialState;

  @override
  ManagePinnedConnectionsState build() => _initialState;
}
