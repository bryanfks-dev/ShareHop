import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_summary_card.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget({
    required ShareIntegrationItem item,
    VoidCallback? onOpenFiles,
  }) {
    return MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, child) => FTheme(data: lightTheme, child: child!),
      home: Scaffold(
        body: Center(
          child: SelectedFilesSummaryCard(item: item, onOpenFiles: onOpenFiles),
        ),
      ),
    );
  }

  group('SelectedFilesSummaryCard', () {
    testWidgets('renders multiple files summary with badge and chevron', (
      tester,
    ) async {
      const item = ShareIntegrationItem();

      await tester.pumpWidget(buildTestWidget(item: item));
      await tester.pumpAndSettle();

      expect(find.text('Campaign selects'), findsOneWidget);
      expect(find.text('3 JPEG images'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.image), findsOneWidget);
      expect(find.byIcon(FLucideIcons.chevronRight), findsOneWidget);
    });

    testWidgets('renders single file card correctly', (tester) async {
      const item = ShareIntegrationItem(
        title: 'vacation.jpg',
        subtitle: '1.0 MB · image/jpeg',
        fileCount: 1,
        totalSize: '1.0 MB',
        files: [
          SharedFileInfo(
            name: 'vacation.jpg',
            size: 1048576,
            mimeType: 'image/jpeg',
          ),
        ],
      );

      await tester.pumpWidget(buildTestWidget(item: item));
      await tester.pumpAndSettle();

      expect(find.text('vacation.jpg'), findsOneWidget);
      expect(find.text('1.0 MB · image/jpeg'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.image), findsOneWidget);
      expect(find.byIcon(FLucideIcons.chevronRight), findsOneWidget);
    });

    testWidgets('renders document icon for non-image file', (tester) async {
      const item = ShareIntegrationItem(
        title: 'report.pdf',
        subtitle: '2.5 MB',
        fileCount: 1,
        totalSize: '2.5 MB',
        files: [
          SharedFileInfo(
            name: 'report.pdf',
            size: 2621440,
            mimeType: 'application/pdf',
          ),
        ],
      );

      await tester.pumpWidget(buildTestWidget(item: item));
      await tester.pumpAndSettle();

      expect(find.text('report.pdf'), findsOneWidget);
      expect(find.text('2.5 MB'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.fileText), findsOneWidget);
    });

    testWidgets('renders zero files state with fileX icon', (tester) async {
      const item = ShareIntegrationItem(
        title: 'No files selected',
        subtitle: 'All files excluded',
        fileCount: 0,
        totalSize: '0 B',
        files: [],
      );

      await tester.pumpWidget(buildTestWidget(item: item));
      await tester.pumpAndSettle();

      expect(find.text('No files selected'), findsOneWidget);
      expect(find.text('All files excluded'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.fileX), findsOneWidget);
    });

    testWidgets('triggers onOpenFiles when card is tapped', (tester) async {
      var isTapped = false;
      const item = ShareIntegrationItem();

      await tester.pumpWidget(
        buildTestWidget(item: item, onOpenFiles: () => isTapped = true),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Campaign selects'));
      await tester.pumpAndSettle();

      expect(isTapped, isTrue);
    });
  });
}
