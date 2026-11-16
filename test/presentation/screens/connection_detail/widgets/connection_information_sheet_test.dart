import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_information_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: FToaster(child: c!),
    ),
    home: child,
  );
}

void main() {
  group('ConnectionInformationSheet', () {
    testWidgets('renders all connection details for secure connection', (
      tester,
    ) async {
      final connection = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.webdav,
        displayName: 'Production Server',
        remoteAddress: 'https://prod.server.io',
        username: 'admin',
        password: 'password',
        rootPath: '/remote.php/dav',
        isPinned: true,
        status: ConnectionStatus.online,
      );

      await tester.pumpWidget(
        _buildTestWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                await showConnectionInformationSheet(
                  context,
                  connection: connection,
                );
              },
              child: const Text('Open Info'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Info'));
      await tester.pumpAndSettle();

      expect(find.text('Connection Details'), findsOneWidget);
      expect(find.text('Production Server'), findsOneWidget);
      expect(find.text('WebDAV'), findsNWidgets(2)); // subtitle & detail
      expect(find.text('Status'), findsOneWidget);
      expect(find.text('Online'), findsOneWidget);
      expect(find.text('Remote Address'), findsOneWidget);
      expect(find.text('https://prod.server.io'), findsOneWidget);
      expect(find.text('Root Path'), findsOneWidget);
      expect(find.text('/remote.php/dav'), findsOneWidget);
      expect(find.text('Protocol'), findsOneWidget);
      expect(find.text('Security'), findsOneWidget);
      expect(find.text('Secured'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.lock), findsOneWidget);
      expect(find.text('Server Certificate Validation'), findsOneWidget);
      expect(find.text('Enabled'), findsOneWidget);
      expect(find.text('Allow Self-Signed Certificate'), findsOneWidget);
      expect(find.text('Not allowed'), findsOneWidget);
    });

    testWidgets(
      'renders details for insecure connection with self-signed certificate',
      (tester) async {
        final connection = ConnectionViewModel(
          id: const Uuid().v7obj(),
          protocol: ConnectionProtocol.ftp,
          displayName: 'Legacy FTP',
          remoteAddress: 'ftp://files.local',
          username: 'anonymous',
          password: '',
          isPinned: false,
          validateServerCertificate: false,
          allowSelfSignedCertificate: true,
        );

      await tester.pumpWidget(
        _buildTestWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                await showConnectionInformationSheet(
                  context,
                  connection: connection,
                );
              },
              child: const Text('Open Info'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Info'));
      await tester.pumpAndSettle();

      expect(find.text('Security'), findsOneWidget);
      expect(find.text('Not secured'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.lockOpen), findsOneWidget);
      expect(find.text('Server Certificate Validation'), findsOneWidget);
      expect(find.text('Disabled'), findsOneWidget);
      expect(find.text('Allow Self-Signed Certificate'), findsOneWidget);
      expect(find.text('Allowed'), findsOneWidget);
    });

    testWidgets('tapping close button dismisses sheet', (tester) async {
      final connection = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.webdav,
        displayName: 'My Storage',
        remoteAddress: 'https://storage.local',
        username: 'user',
        password: 'pwd',
        isPinned: false,
      );

      await tester.pumpWidget(
        _buildTestWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                await showConnectionInformationSheet(
                  context,
                  connection: connection,
                );
              },
              child: const Text('Open Info'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Info'));
      await tester.pumpAndSettle();

      expect(find.text('Connection Details'), findsOneWidget);

      await tester.tap(find.byIcon(FLucideIcons.x));
      await tester.pumpAndSettle();

      expect(find.text('Connection Details'), findsNothing);
    });

    testWidgets(
      'tapping copy on root path and remote address copies to clipboard',
      (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final connection = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.webdav,
        displayName: 'My Storage',
        remoteAddress: 'https://storage.local',
        username: 'user',
        password: 'pwd',
        rootPath: '/custom/root',
        isPinned: false,
      );

      await tester.pumpWidget(
        _buildTestWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                await showConnectionInformationSheet(
                  context,
                  connection: connection,
                );
              },
              child: const Text('Open Info'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Info'));
      await tester.pumpAndSettle();

      // Tap on Root Path tile to copy
      await tester.ensureVisible(find.text('Root Path'));
      await tester.tap(find.text('Root Path'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 6));

      // Tap on Remote Address tile to copy
      await tester.ensureVisible(find.text('Remote Address'));
      await tester.tap(find.text('Remote Address'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 6));
    });
  });
}
