import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_path/destination_path_picker_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  group('DestinationPathPickerSheet', () {
    testWidgets('renders input and confirms edited path', (tester) async {
      String? resultPath;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          builder: (context, c) => FTheme(
            data: lightTheme,
            child: FToaster(child: c!),
          ),
          home: Scaffold(
            body: Builder(
              builder: (context) => FButton(
                onPress: () async {
                  resultPath = await showDestinationPathPickerSheet(
                    context,
                    initialPath: '/initial/folder',
                  );
                },
                child: const Text('Open path sheet'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open path sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Destination Path'), findsOneWidget);
      expect(find.text('/initial/folder'), findsOneWidget);

      final editables = find.byType(EditableText);
      await tester.enterText(editables.first, '/new/destination');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm path'));
      await tester.pumpAndSettle();

      expect(resultPath, equals('/new/destination'));
    });
  });
}
