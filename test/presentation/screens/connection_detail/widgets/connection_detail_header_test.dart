import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_detail_header.dart';
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
        body: child,
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

  group('ConnectionDetailHeader', () {
    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionDetailHeader(connection: testConnection),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Production Server'), findsOneWidget);
      expect(find.text('Connection detail'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.chevronLeft), findsOneWidget);
      expect(find.byIcon(FLucideIcons.ellipsis), findsOneWidget);
    });

    testWidgets('has access to controller and controls popover menu', (
      tester,
    ) async {
      final popoverController = FPopoverController(vsync: const TestVSync());

      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionDetailHeader(
            connection: testConnection,
            controller: popoverController,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Check connection'), findsNothing);

      unawaited(popoverController.show());
      await tester.pumpAndSettle();

      expect(find.text('Check connection'), findsOneWidget);
      expect(find.text('Edit connection'), findsOneWidget);
      expect(find.text('Delete connection'), findsOneWidget);

      unawaited(popoverController.hide());
      await tester.pumpAndSettle();

      expect(find.text('Check connection'), findsNothing);

      popoverController.dispose();
    });

    testWidgets('calls onEdit when edit item is tapped', (tester) async {
      var editCalled = false;

      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionDetailHeader(
            connection: testConnection,
            onEdit: () {
              editCalled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Edit connection'));
      await tester.pumpAndSettle();

      expect(editCalled, isTrue);
    });

    testWidgets('calls onCheckConnection when check item is tapped', (
      tester,
    ) async {
      var checkCalled = false;

      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionDetailHeader(
            connection: testConnection,
            onCheckConnection: () {
              checkCalled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Check connection'));
      await tester.pumpAndSettle();

      expect(checkCalled, isTrue);
    });

    testWidgets('calls onDelete when delete item is tapped', (tester) async {
      var deleteCalled = false;

      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionDetailHeader(
            connection: testConnection,
            onDelete: () {
              deleteCalled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete connection'));
      await tester.pumpAndSettle();

      expect(deleteCalled, isTrue);
    });
  });
}
