import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_file_item_card.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        ...FLocalizations.localizationsDelegates,
      ],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('SelectedFileItemCard', () {
    testWidgets('renders active file with exclude action button', (
      tester,
    ) async {
      var isActionPressed = false;
      const file = SharedFileInfo(
        name: 'vacation.jpg',
        size: 1048576,
        mimeType: 'image/jpeg',
      );

      await tester.pumpWidget(
        buildTestWidget(
          SelectedFileItemCard(
            file: file,
            isExcluded: false,
            onActionPress: () => isActionPressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('vacation.jpg'), findsOneWidget);
      expect(find.text('1.0 MB'), findsOneWidget);
      expect(find.text('JPG'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.x), findsOneWidget);

      await tester.tap(find.byIcon(FLucideIcons.x));
      await tester.pumpAndSettle();

      expect(isActionPressed, isTrue);
    });

    testWidgets('renders excluded file with include action button', (
      tester,
    ) async {
      var isActionPressed = false;
      const file = SharedFileInfo(
        name: 'archive.zip',
        size: 2097152,
        mimeType: 'application/zip',
      );

      await tester.pumpWidget(
        buildTestWidget(
          SelectedFileItemCard(
            file: file,
            isExcluded: true,
            onActionPress: () => isActionPressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('archive.zip'), findsOneWidget);
      expect(find.text('2.0 MB'), findsOneWidget);
      expect(find.text('ZIP'), findsOneWidget);
      expect(find.text('Excluded'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.plus), findsOneWidget);

      await tester.tap(find.byIcon(FLucideIcons.plus));
      await tester.pumpAndSettle();

      expect(isActionPressed, isTrue);
    });
  });
}
