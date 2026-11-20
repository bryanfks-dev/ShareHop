import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/share_integration_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  Widget buildTestWidget({
    ShareIntegrationData data = const ShareIntegrationData(),
    List<ConnectionViewModel>? availableConnections,
    UuidValue? selectedConnectionId,
    ValueChanged<ConnectionViewModel>? onConnectionChanged,
    VoidCallback? onUpload,
    VoidCallback? onBrowse,
    VoidCallback? onOpenAddConnection,
    VoidCallback? onSelectDestination,
    VoidCallback? onClose,
    ValueChanged<bool>? onPreserveFilenamesChanged,
    VoidCallback? onOpenFiles,
    ValueChanged<SharedFileInfo>? onExcludeFile,
    ValueChanged<SharedFileInfo>? onIncludeFile,
    ValueChanged<int>? onSimultaneousTransfersChanged,
  }) {
    return MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, child) => FTheme(
        data: lightTheme,
        child: FToaster(child: child!),
      ),
      home: Scaffold(
        body: ShareIntegrationSheet(
          data: data,
          availableConnections: availableConnections,
          selectedConnectionId: selectedConnectionId,
          onConnectionChanged: onConnectionChanged,
          onUpload: onUpload,
          onBrowse: onBrowse,
          onOpenAddConnection: onOpenAddConnection,
          onSelectDestination: onSelectDestination,
          onClose: onClose,
          onPreserveFilenamesChanged: onPreserveFilenamesChanged,
          onOpenFiles: onOpenFiles,
          onExcludeFile: onExcludeFile,
          onIncludeFile: onIncludeFile,
          onSimultaneousTransfersChanged: onSimultaneousTransfersChanged,
        ),
      ),
    );
  }

  group('ShareIntegrationSheet', () {
    testWidgets('renders all mock details correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Transfer with ShareHop'), findsOneWidget);
      expect(find.text('3 file(s) selected (24.8 MB)'), findsOneWidget);
      expect(find.text('Campaign selects'), findsOneWidget);
      expect(find.text('3 JPEG images'), findsOneWidget);
      expect(find.text('3'), findsOneWidget); // Badge
      expect(find.text('Destination'), findsOneWidget);
      expect(find.text('SFTP'), findsOneWidget);
      expect(find.text('Production'), findsOneWidget);
      expect(find.text('prod.relaydock.io'), findsOneWidget);
      expect(find.text('/var/www/releases/assets'), findsOneWidget);
      expect(find.text('Browse'), findsOneWidget);
      expect(find.text('Simultaneous transfers'), findsOneWidget);
      expect(find.text('3 transfers'), findsOneWidget);
      expect(find.text('Add new connection'), findsNothing);
      expect(find.text('Open ShareHop to configure it'), findsNothing);
      expect(find.text('Open'), findsNothing);
      expect(
        find.text(
          'These 3 file(s) will be retained while you '
          'set up the new connection.',
        ),
        findsNothing,
      );
      expect(find.text('Upload 3 files'), findsOneWidget);
      expect(
        find.text('Transfer continues securely in the background.'),
        findsOneWidget,
      );
    });

    testWidgets('triggers callbacks on actions', (tester) async {
      var isUploadCalled = false;
      var isBrowseCalled = false;
      var isOpenCalled = false;
      var isDestinationTapped = false;

      await tester.pumpWidget(
        buildTestWidget(
          onUpload: () => isUploadCalled = true,
          onBrowse: () => isBrowseCalled = true,
          onOpenAddConnection: () => isOpenCalled = true,
          onSelectDestination: () => isDestinationTapped = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Upload 3 files'));
      await tester.pumpAndSettle();
      expect(isUploadCalled, isTrue);

      await tester.tap(find.text('Browse'));
      await tester.pumpAndSettle();
      expect(isBrowseCalled, isTrue);

      await tester.tap(find.text('Confirm path'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Production'));
      await tester.pumpAndSettle();
      expect(isDestinationTapped, isTrue);

      // Verify onOpenAddConnection when no connections exist
      await tester.pumpWidget(
        buildTestWidget(
          availableConnections: const [],
          onOpenAddConnection: () => isOpenCalled = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Open'));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(isOpenCalled, isTrue);
    });

    testWidgets('showShareIntegrationSheet opens modal sheet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
          home: Builder(
            builder: (context) {
              return Center(
                child: ElevatedButton(
                  onPressed: () => showShareIntegrationSheet(context),
                  child: const Text('Open'),
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Transfer with ShareHop'), findsOneWidget);
      expect(find.text('Upload 3 files'), findsOneWidget);
      expect(find.text('Destination'), findsOneWidget);
    });

    testWidgets(
      'clicking image opens selected files sheet and allows excluding',
      (tester) async {
        SharedFileInfo? excludedFile;

        await tester.pumpWidget(
          buildTestWidget(onExcludeFile: (file) => excludedFile = file),
        );
        await tester.pumpAndSettle();

        // Tap on the image icon to view files
        await tester.tap(find.byIcon(FLucideIcons.image));
        await tester.pumpAndSettle();

        // Selected files sheet is opened
        expect(find.text('Selected Files'), findsOneWidget);
        expect(find.text('3 file(s) selected'), findsOneWidget);
        expect(find.text('IMG_4021.jpg'), findsOneWidget);
        expect(find.text('IMG_4022.jpg'), findsOneWidget);
        expect(find.text('IMG_4023.jpg'), findsOneWidget);

        // Exclude one file
        final excludeButtons = find.byIcon(FLucideIcons.x);
        expect(excludeButtons, findsNWidgets(3));
        await tester.tap(excludeButtons.first);
        await tester.pumpAndSettle();

        expect(excludedFile, isNotNull);
        expect(excludedFile!.name, 'IMG_4021.jpg');

        // Now 2 active files and 1 excluded file shown in sheet
        expect(find.text('2 file(s) selected'), findsOneWidget);
        expect(find.text('Excluded (1)'), findsOneWidget);
        expect(find.bySemanticsLabel('Include IMG_4021.jpg'), findsOneWidget);
      },
    );

    testWidgets('does not render AddConnectionCard when connections exist', (
      tester,
    ) async {
      final connection = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.sftp,
        displayName: 'Production Server',
        remoteAddress: 'prod.example.com',
        username: 'user',
        password: 'password',
        isPinned: true,
        rootPath: '/var/www',
        status: ConnectionStatus.online,
      );

      await tester.pumpWidget(
        buildTestWidget(availableConnections: [connection]),
      );
      await tester.pumpAndSettle();

      expect(find.text('Add new connection'), findsNothing);
      expect(
        find.text(
          'These 3 file(s) will be retained while you '
          'set up the new connection.',
        ),
        findsNothing,
      );
    });

    testWidgets(
      'renders AddConnectionCard when availableConnections is empty',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(availableConnections: const []),
        );
        await tester.pumpAndSettle();

        expect(find.text('Add new connection'), findsOneWidget);
        expect(
          find.text(
            'These 3 file(s) will be retained while you '
            'set up the new connection.',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'tapping simultaneous transfers opens sheet and triggers callback',
      (tester) async {
        int? selectedLimit;

        await tester.pumpWidget(
          buildTestWidget(
            onSimultaneousTransfersChanged: (limit) => selectedLimit = limit,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Simultaneous transfers'), findsOneWidget);
        expect(find.text('3 transfers'), findsOneWidget);

        await tester.tap(find.text('Simultaneous transfers'));
        await tester.pumpAndSettle();

        expect(
          find.text('Select simultaneous transfers limit'),
          findsOneWidget,
        );

        await tester.tap(find.text('5 transfer(s)'));
        await tester.pumpAndSettle();

        expect(selectedLimit, 5);
        expect(find.text('5 transfers'), findsOneWidget);
      },
    );
  });
}
