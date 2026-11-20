import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/screens/edit_connection/widgets/edit_connection_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        ...FLocalizations.localizationsDelegates,
      ],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: child),
    );
  }

  group('EditConnectionHeader', () {
    testWidgets('renders connection displayName and handles back button', (
      tester,
    ) async {
      final conn = ConnectionViewModel(
        id: const Uuid().v7obj(),
        protocol: ConnectionProtocol.sftp,
        displayName: 'My SFTP Server',
        remoteAddress: 'sftp.example.com',
        username: 'admin',
        password: 'pwd',
        isPinned: false,
      );

      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => Scaffold(
                      body: EditConnectionHeader(connection: conn),
                    ),
                  ),
                );
              },
              child: const Text('Push'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Push'));
      await tester.pumpAndSettle();

      expect(find.text('Edit connection'), findsOneWidget);
      expect(find.text('My SFTP Server'), findsOneWidget);

      await tester.tap(find.byIcon(FLucideIcons.chevronLeft));
      await tester.pumpAndSettle();

      expect(find.text('Push'), findsOneWidget);
    });
  });
}
