import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/screens/connection_detail/screen.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_detail_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

Widget _buildTestWidget(Widget child) {
  return ProviderScope(
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
  group('ConnectionDetailScreen', () {
    testWidgets('renders header and connection details', (tester) async {
      final connection = ConnectionViewModel(
        id: 'conn-1',
        protocol: ConnectionProtocol.webdav,
        displayName: 'Production Server',
        remoteAddress: 'https://prod.server.io',
        username: 'admin',
        password: 'password',
        isPinned: true,
        status: ConnectionStatus.online,
      );

      await tester.pumpWidget(
        _buildTestWidget(ConnectionDetailScreen(connection: connection)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ConnectionDetailHeader), findsOneWidget);
      expect(find.text('Production Server'), findsWidgets);
      expect(find.text('https://prod.server.io'), findsWidgets);
    });
  });
}
