import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_card.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_picker_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: Scaffold(body: Center(child: child)),
    );
  }

  final testConn1 = ConnectionViewModel(
    id: const Uuid().v7obj(),
    protocol: ConnectionProtocol.sftp,
    displayName: 'Alpha SFTP Server',
    remoteAddress: 'sftp.alpha.io',
    username: 'user1',
    password: 'password',
    isPinned: true,
    rootPath: '/home/alpha',
    status: ConnectionStatus.online,
  );

  final testConn2 = ConnectionViewModel(
    id: const Uuid().v7obj(),
    protocol: ConnectionProtocol.webdav,
    displayName: 'Beta WebDAV Server',
    remoteAddress: 'https://dav.beta.io',
    username: 'user2',
    password: 'password',
    isPinned: false,
    rootPath: '/webdav/beta',
  );

  final testConn3 = ConnectionViewModel(
    id: const Uuid().v7obj(),
    protocol: ConnectionProtocol.smb,
    displayName: 'Gamma SMB Share',
    remoteAddress: 'smb://gamma.local',
    username: 'user3',
    password: 'password',
    isPinned: false,
    rootPath: '/shares/gamma',
    status: ConnectionStatus.ready,
  );

  group('DestinationConnectionPickerSheet', () {
    testWidgets(
      'showDestinationConnectionPickerSheet opens and returns selected '
      'connection',
      (tester) async {
        ConnectionViewModel? selectedConn;

        await tester.pumpWidget(
          buildTestWidget(
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  selectedConn = await showDestinationConnectionPickerSheet(
                    context,
                    connections: [testConn1, testConn2],
                    selectedId: testConn1.id,
                  );
                },
                child: const Text('Open Connection Picker'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Open Connection Picker'));
        await tester.pumpAndSettle();

        expect(find.text('Select Destination'), findsOneWidget);
        expect(
          find.text('Choose a connection to transfer files'),
          findsOneWidget,
        );
        expect(find.text('Alpha SFTP Server'), findsOneWidget);
        expect(find.text('Beta WebDAV Server'), findsOneWidget);

        // Checkmark should be present for the selected connection
        expect(find.byIcon(FLucideIcons.check), findsOneWidget);

        // Select the second connection
        await tester.tap(find.text('Beta WebDAV Server'));
        await tester.pumpAndSettle();

        expect(selectedConn, testConn2);
        expect(find.text('Select Destination'), findsNothing);
      },
    );

    testWidgets('showConnectionPickerSheet alias works identically', (
      tester,
    ) async {
      ConnectionViewModel? selectedConn;

      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                selectedConn = await showConnectionPickerSheet(
                  context,
                  connections: [testConn1, testConn2],
                );
              },
              child: const Text('Open Alias Picker'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Alias Picker'));
      await tester.pumpAndSettle();

      expect(find.text('Select Destination'), findsOneWidget);

      await tester.tap(find.text('Alpha SFTP Server'));
      await tester.pumpAndSettle();

      expect(selectedConn, testConn1);
    });

    testWidgets('filters by protocol chip when multiple protocols exist', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                await showDestinationConnectionPickerSheet(
                  context,
                  connections: [testConn1, testConn2, testConn3],
                );
              },
              child: const Text('Open Filter Picker'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Filter Picker'));
      await tester.pumpAndSettle();

      // Protocol chips should be present
      expect(find.text('All'), findsOneWidget);
      expect(find.text('SFTP'), findsWidgets);
      expect(find.text('WebDAV'), findsWidgets);
      expect(find.text('SMB'), findsWidgets);

      // Filter by WebDAV
      await tester.tap(find.text('WebDAV').first);
      await tester.pumpAndSettle();

      expect(find.text('Beta WebDAV Server'), findsOneWidget);
      expect(find.text('Alpha SFTP Server'), findsNothing);
      expect(find.text('Gamma SMB Share'), findsNothing);

      // Filter back to All
      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();

      expect(find.text('Alpha SFTP Server'), findsOneWidget);
      expect(find.text('Beta WebDAV Server'), findsOneWidget);
      expect(find.text('Gamma SMB Share'), findsOneWidget);
    });

    testWidgets('renders pinned and other section headers when both exist', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                await showDestinationConnectionPickerSheet(
                  context,
                  connections: [testConn1, testConn2],
                );
              },
              child: const Text('Open Section Picker'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Section Picker'));
      await tester.pumpAndSettle();

      expect(find.text('Pinned Connections'), findsOneWidget);
      expect(find.text('Other Connections'), findsOneWidget);
    });

    testWidgets(
      'renders empty state with add connection action when connections list '
      'is empty',
      (tester) async {
        var addConnectionCalled = false;

        await tester.pumpWidget(
          buildTestWidget(
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  await showDestinationConnectionPickerSheet(
                    context,
                    connections: const [],
                    onOpenAddConnection: () => addConnectionCalled = true,
                  );
                },
                child: const Text('Open Empty Picker'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Open Empty Picker'));
        await tester.pumpAndSettle();

        expect(find.text('No available connections'), findsOneWidget);
        expect(find.text('Add connection'), findsOneWidget);

        await tester.tap(find.text('Add connection'));
        await tester.pumpAndSettle();

        expect(addConnectionCalled, isTrue);
      },
    );

    testWidgets(
      'clicking Add New Connection at the bottom triggers onOpenAddConnection',
      (tester) async {
        var addConnectionCalled = false;

        await tester.pumpWidget(
          buildTestWidget(
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  await showDestinationConnectionPickerSheet(
                    context,
                    connections: [testConn1],
                    onOpenAddConnection: () => addConnectionCalled = true,
                  );
                },
                child: const Text('Open Bottom Add Picker'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Open Bottom Add Picker'));
        await tester.pumpAndSettle();

        expect(find.text('Add New Connection'), findsOneWidget);
        await tester.tap(find.text('Add New Connection'));
        await tester.pumpAndSettle();

        expect(addConnectionCalled, isTrue);
      },
    );

    testWidgets('dismisses sheet on barrier tap and triggers onClose', (
      tester,
    ) async {
      var closeCalled = false;

      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                await showDestinationConnectionPickerSheet(
                  context,
                  connections: [testConn1],
                  onClose: () => closeCalled = true,
                );
              },
              child: const Text('Open Close Picker'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Close Picker'));
      await tester.pumpAndSettle();

      expect(find.text('Select Destination'), findsOneWidget);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(closeCalled, isTrue);
      expect(find.text('Select Destination'), findsNothing);
    });
  });

  group('DestinationConnectionCard', () {
    testWidgets('renders initial destination details correctly', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DestinationConnectionCard(
            destination: ShareIntegrationDestination(
              name: 'My Remote Host',
              host: 'remote.example.com',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('My Remote Host'), findsOneWidget);
      expect(find.text('remote.example.com'), findsOneWidget);
      expect(find.text('SFTP'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.chevronDown), findsOneWidget);
    });

    testWidgets(
      'opens sheet and updates connection without relying on callbacks',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            DestinationConnectionCard(
              destination: const ShareIntegrationDestination(
                name: 'Initial Host',
                host: 'initial.example.com',
              ),
              availableConnections: [testConn1, testConn2],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Initial Host'), findsOneWidget);

        // Tap the card to open picker
        await tester.tap(find.text('Initial Host'));
        await tester.pumpAndSettle();

        expect(find.text('Select Destination'), findsOneWidget);
        expect(find.text('Beta WebDAV Server'), findsOneWidget);

        // Select Beta WebDAV Server
        await tester.tap(find.text('Beta WebDAV Server'));
        await tester.pumpAndSettle();

        // Card should now display the newly selected connection
        expect(find.text('Beta WebDAV Server'), findsOneWidget);
        expect(find.text('https://dav.beta.io'), findsOneWidget);
        expect(find.text('Initial Host'), findsNothing);
      },
    );

    testWidgets('notifies optional onConnectionChanged and onTap if provided', (
      tester,
    ) async {
      var tapCalled = false;
      ConnectionViewModel? changedConn;

      await tester.pumpWidget(
        buildTestWidget(
          DestinationConnectionCard(
            destination: const ShareIntegrationDestination(
              name: 'Server A',
              host: 'a.example.com',
            ),
            availableConnections: [testConn1, testConn2],
            onTap: () => tapCalled = true,
            onConnectionChanged: (c) => changedConn = c,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Server A'));
      await tester.pumpAndSettle();
      expect(tapCalled, isTrue);

      await tester.tap(find.text('Alpha SFTP Server'));
      await tester.pumpAndSettle();

      expect(changedConn, testConn1);
      expect(find.text('Alpha SFTP Server'), findsOneWidget);
    });
  });
}
