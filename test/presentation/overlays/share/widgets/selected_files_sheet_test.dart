import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  const testFiles = [
    SharedFileInfo(name: 'IMG_4021.jpg', size: 8700000, mimeType: 'image/jpeg'),
    SharedFileInfo(
      name: 'document.pdf',
      size: 1500000,
      mimeType: 'application/pdf',
    ),
    SharedFileInfo(
      name: 'archive.zip',
      size: 5200000,
      mimeType: 'application/zip',
    ),
  ];

  Widget buildTestWidget({
    List<SharedFileInfo> files = testFiles,
    List<SharedFileInfo> excludedFiles = const [],
    ValueChanged<SharedFileInfo>? onExcludeFile,
    ValueChanged<SharedFileInfo>? onIncludeFile,
    VoidCallback? onClose,
  }) {
    return MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, child) => FTheme(
        data: lightTheme,
        child: FToaster(child: child!),
      ),
      home: Scaffold(
        body: SelectedFilesSheet(
          initialFiles: files,
          initialExcludedFiles: excludedFiles,
          onExcludeFile: onExcludeFile,
          onIncludeFile: onIncludeFile,
          onClose: onClose,
        ),
      ),
    );
  }

  group('SelectedFilesSheet', () {
    testWidgets(
      'renders all initial files with extension badges and summary bar',
      (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        expect(find.text('Selected Files'), findsOneWidget);
        expect(find.text('3 file(s) selected'), findsOneWidget);
        expect(find.text('IMG_4021.jpg'), findsOneWidget);
        expect(find.text('document.pdf'), findsOneWidget);
        expect(find.text('archive.zip'), findsOneWidget);

        expect(find.text('JPG'), findsOneWidget);
        expect(find.text('PDF'), findsOneWidget);
        expect(find.text('ZIP'), findsOneWidget);

        expect(find.text('Exclude all'), findsOneWidget);
      },
    );

    testWidgets('excluding a file updates sections and invokes onExcludeFile', (
      tester,
    ) async {
      SharedFileInfo? excluded;
      await tester.pumpWidget(
        buildTestWidget(onExcludeFile: (file) => excluded = file),
      );
      await tester.pumpAndSettle();

      final excludeButtons = find.byIcon(FLucideIcons.x);
      expect(excludeButtons, findsNWidgets(3));

      await tester.tap(excludeButtons.first);
      await tester.pumpAndSettle();

      expect(excluded, isNotNull);
      expect(excluded!.name, 'IMG_4021.jpg');

      expect(find.text('2 file(s) selected'), findsOneWidget);
      expect(find.text('Excluded (1)'), findsOneWidget);
      expect(find.text('Included (2)'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.plus), findsOneWidget);
    });

    testWidgets('including an excluded file moves it back to active list', (
      tester,
    ) async {
      SharedFileInfo? included;
      await tester.pumpWidget(
        buildTestWidget(
          files: [testFiles[0]],
          excludedFiles: [testFiles[1]],
          onIncludeFile: (file) => included = file,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1 file(s) selected'), findsOneWidget);
      expect(find.text('Excluded (1)'), findsOneWidget);

      await tester.tap(find.byIcon(FLucideIcons.plus));
      await tester.pumpAndSettle();

      expect(included, isNotNull);
      expect(included!.name, 'document.pdf');
      expect(find.text('2 file(s) selected'), findsOneWidget);
      expect(find.text('Excluded (1)'), findsNothing);
    });

    testWidgets(
      'Exclude all button excludes all files and displays empty state',
      (tester) async {
        final excludedList = <SharedFileInfo>[];
        await tester.pumpWidget(
          buildTestWidget(onExcludeFile: excludedList.add),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Exclude all'));
        await tester.pumpAndSettle();

        expect(excludedList.length, 3);
        expect(find.text('0 file(s) selected'), findsOneWidget);
        expect(find.text('No files selected'), findsOneWidget);
        expect(find.text('All files have been excluded.'), findsOneWidget);
        expect(find.text('Restore all files'), findsOneWidget);
        expect(find.text('Excluded (3)'), findsOneWidget);
      },
    );

    testWidgets('Restore All Files button restores all excluded files', (
      tester,
    ) async {
      final includedList = <SharedFileInfo>[];
      await tester.pumpWidget(
        buildTestWidget(
          files: const [],
          excludedFiles: testFiles,
          onIncludeFile: includedList.add,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No files selected'), findsOneWidget);
      await tester.tap(find.text('Restore all files'));
      await tester.pumpAndSettle();

      expect(includedList.length, 3);
      expect(find.text('3 file(s) selected'), findsOneWidget);
      expect(find.text('No files selected'), findsNothing);
    });

    testWidgets(
      'showSelectedFilesSheet opens modal sheet and dismisses on barrier tap',
      (tester) async {
        var isClosed = false;
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: const [
              ...FLocalizations.localizationsDelegates,
            ],
            builder: (context, child) => FTheme(
              data: lightTheme,
              child: FToaster(child: child!),
            ),
            home: Builder(
              builder: (context) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () => showSelectedFilesSheet(
                      context,
                      files: testFiles,
                      onClose: () => isClosed = true,
                    ),
                    child: const Text('Open Files Sheet'),
                  ),
                );
              },
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Open Files Sheet'));
        await tester.pumpAndSettle();

        expect(find.text('Selected Files'), findsOneWidget);
        expect(find.text('3 file(s) selected'), findsOneWidget);

        await tester.tapAt(const Offset(10, 10));
        await tester.pumpAndSettle();

        expect(find.text('Selected Files'), findsNothing);
        expect(isClosed, isTrue);
      },
    );
  });
}
