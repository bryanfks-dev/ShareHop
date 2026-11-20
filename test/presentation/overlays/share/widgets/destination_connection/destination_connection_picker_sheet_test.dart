import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_picker_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  final connection1 = ConnectionViewModel(
    id: const Uuid().v7obj(),
    displayName: 'Office Server',
    remoteAddress: 'https://office.local',
    username: 'admin',
    password: 'password',
    protocol: ConnectionProtocol.webdav,
    isPinned: true,
  );

  final connection2 = ConnectionViewModel(
    id: const Uuid().v7obj(),
    displayName: 'Backup NAS',
    remoteAddress: '192.168.1.50',
    username: 'admin',
    password: 'password',
    protocol: ConnectionProtocol.smb,
    isPinned: false,
  );

  group('DestinationConnectionPickerSheet', () {
    testWidgets('shows sheet, filters by protocol, and selects connection', (
      tester,
    ) async {
      ConnectionViewModel? selected;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          builder: (context, c) => FTheme(
            data: lightTheme,
            child: FToaster(child: c!),
          ),
          home: Scaffold(
            body: Builder(
              builder: (context) => FButton(
                onPress: () async {
                  selected = await showDestinationConnectionPickerSheet(
                    context,
                    connections: [connection1, connection2],
                  );
                },
                child: const Text('Open picker'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open picker'));
      await tester.pumpAndSettle();

      expect(find.text('Select Destination'), findsOneWidget);
      expect(find.text('Office Server'), findsOneWidget);
      expect(find.text('Backup NAS'), findsOneWidget);

      await tester.tap(find.text('Office Server'));
      await tester.pumpAndSettle();

      expect(selected, equals(connection1));
    });
  });
}
