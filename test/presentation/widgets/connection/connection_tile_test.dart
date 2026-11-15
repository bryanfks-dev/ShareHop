import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_tile.dart';
import 'package:uuid/uuid_value.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(body: child),
  );
}

void main() {
  group('ConnectionTile', () {
    testWidgets(
      'renders connection details and triggers onPress',
      (tester) async {
      var pressed = false;
      final connection = ConnectionViewModel(
        id: UuidValue.fromString('11111111-1111-1111-1111-111111111111'),
        protocol: ConnectionProtocol.webdav,
        displayName: 'My Storage',
        remoteAddress: 'https://storage.cloud.com',
        username: 'user',
        password: 'pass',
        isPinned: true,
        status: ConnectionStatus.online,
      );

      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionTile(
            connection: connection,
            onPress: () => pressed = true,
          ),
        ),
      );

      expect(find.text('My Storage'), findsOneWidget);
      expect(find.text('https://storage.cloud.com'), findsOneWidget);
      expect(find.byType(ConnectionTile), findsOneWidget);

      await tester.tap(find.byType(ConnectionTile));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });
}
