import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/open_split_workspace_tile.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid_value.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

void main() {
  final testConnection = ConnectionViewModel(
    id: UuidValue.fromString('11111111-1111-1111-1111-111111111111'),
    protocol: ConnectionProtocol.webdav,
    displayName: 'Test Server',
    remoteAddress: 'https://test.server',
    username: 'admin',
    password: 'password',
    isPinned: false,
  );

  group('OpenSplitWorkspaceTile', () {
    testWidgets('renders tile texts and icons properly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          OpenSplitWorkspaceTile(connection: testConnection),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Open split workspace'), findsOneWidget);
      expect(
        find.text('See device and remote file system in landscape'),
        findsOneWidget,
      );
      expect(find.byIcon(FLucideIcons.chevronRight), findsOneWidget);
      expect(find.byIcon(FLucideIcons.columns), findsOneWidget);
    });
  });
}
