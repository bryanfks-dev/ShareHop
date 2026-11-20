import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_identity_card.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid_value.dart';

Widget _buildTestWidget(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: Scaffold(
        body: SingleChildScrollView(child: child),
      ),
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

  group('ConnectionIdentityCard', () {
    testWidgets('renders connection details correctly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionIdentityCard(connection: testConnection),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Production Server'), findsOneWidget);
      expect(find.text('https://prod.server.io'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.info), findsOneWidget);
    });

    testWidgets('opens connection information sheet on info tap', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionIdentityCard(connection: testConnection),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(FLucideIcons.info));
      await tester.pumpAndSettle();

      expect(find.text('Connection Details'), findsOneWidget);
    });
  });
}
