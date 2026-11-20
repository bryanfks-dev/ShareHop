import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/connection_identity_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/landscape_workspace_path_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/quick_actions_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/recent_folders_and_files_section.dart';
import 'package:sharehop/presentation/screens/connection_detail/sections/storage_usage_section.dart';
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
    displayName: 'Test Section Server',
    remoteAddress: 'https://server.local',
    username: 'admin',
    password: 'password',
    isPinned: false,
  );

  group('Connection Detail Sections', () {
    testWidgets('ConnectionIdentitySection renders properly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionIdentitySection(connection: testConnection),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Section Server'), findsOneWidget);
    });

    testWidgets('QuickActionsSection renders properly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const QuickActionsSection(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Quick Actions'), findsOneWidget);
      expect(find.text('Browse files'), findsOneWidget);
      expect(find.text('Transfer files'), findsOneWidget);
    });

    testWidgets('StorageUsageSection renders properly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          StorageUsageSection(connection: testConnection),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Remote Storage'), findsOneWidget);
    });

    testWidgets('RecentFoldersAndFilesSection renders properly', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const RecentFoldersAndFilesSection(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Recent Folders & Files'), findsOneWidget);
      expect(find.text('releases'), findsOneWidget);
      expect(find.text('assets'), findsOneWidget);
      expect(find.text('product-demo-final.mp4'), findsOneWidget);
      expect(find.text('release-notes.md'), findsOneWidget);
    });

    testWidgets('LandscapeWorkspacePathSection renders properly', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          LandscapeWorkspacePathSection(connection: testConnection),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Open split workspace'), findsOneWidget);
    });
  });
}
