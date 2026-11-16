import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/forms/web_dav/connection_group.dart';

Widget _buildTestWidget({
  required TextEditingController remoteAddressController,
  TextEditingController? displayNameController,
  TextEditingController? rootPathController,
  GlobalKey<FormState>? formKey,
  bool enabled = true,
}) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, child) => FTheme(
      data: lightTheme,
      child: FToaster(child: FTooltipGroup(child: child!)),
    ),
    home: Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: WebDavFormConnectionGroup(
            remoteAddressController: remoteAddressController,
            displayNameController: displayNameController,
            rootPathController: rootPathController,
            enabled: enabled,
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('WebDavFormConnectionGroup', () {
    testWidgets('renders https:// prefix dropdown by default', (tester) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildTestWidget(remoteAddressController: controller),
      );
      await tester.pumpAndSettle();

      expect(find.text('https://'), findsOneWidget);
      expect(find.text('Server url'), findsOneWidget);
    });

    testWidgets('initializes to http:// if remoteAddress starts with http://', (
      tester,
    ) async {
      final controller = TextEditingController(
        text: 'http://my-nas.local/webdav',
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildTestWidget(remoteAddressController: controller),
      );
      await tester.pumpAndSettle();

      expect(find.text('http://'), findsOneWidget);
      expect(find.text('my-nas.local/webdav'), findsOneWidget);
      expect(controller.text, 'http://my-nas.local/webdav');
    });

    testWidgets('opens dropdown and allows selecting http://', (tester) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildTestWidget(remoteAddressController: controller),
      );
      await tester.pumpAndSettle();

      expect(find.text('https://'), findsOneWidget);

      // Tap on the protocol dropdown prefix
      await tester.tap(find.text('https://'));
      await tester.pumpAndSettle();

      // Now popover menu options should be visible
      expect(find.text('http://'), findsOneWidget);

      // Tap http:// option
      await tester.tap(find.text('http://'));
      await tester.pumpAndSettle();

      // Dropdown prefix should now show http://
      expect(find.text('http://'), findsOneWidget);

      // Enter server host/path
      final editables = find.byType(EditableText);
      await tester.enterText(editables.at(1), 'example.com/dav');
      await tester.pumpAndSettle();

      expect(controller.text, 'http://example.com/dav');
    });

    testWidgets(
      'automatically detects pasted URL with https:// and strips scheme',
      (tester) async {
        final controller = TextEditingController();
        addTearDown(controller.dispose);

        await tester.pumpWidget(
          _buildTestWidget(remoteAddressController: controller),
        );
        await tester.pumpAndSettle();

        final editables = find.byType(EditableText);
        await tester.enterText(
          editables.at(1),
          'https://cloud.company.com/remote.php/webdav',
        );
        await tester.pumpAndSettle();

        expect(find.text('https://'), findsOneWidget);
        expect(
          find.text('cloud.company.com/remote.php/webdav'),
          findsOneWidget,
        );
        expect(controller.text, 'https://cloud.company.com/remote.php/webdav');
      },
    );

    testWidgets(
      'automatically detects pasted URL with http:// and switches dropdown',
      (tester) async {
        final controller = TextEditingController();
        addTearDown(controller.dispose);

        await tester.pumpWidget(
          _buildTestWidget(remoteAddressController: controller),
        );
        await tester.pumpAndSettle();

        final editables = find.byType(EditableText);
        await tester.enterText(
          editables.at(1),
          'http://192.168.1.100:8080/webdav',
        );
        await tester.pumpAndSettle();

        expect(find.text('http://'), findsOneWidget);
        expect(find.text('192.168.1.100:8080/webdav'), findsOneWidget);
        expect(controller.text, 'http://192.168.1.100:8080/webdav');
      },
    );

    testWidgets('validates required and URL format correctly', (tester) async {
      final controller = TextEditingController();
      final formKey = GlobalKey<FormState>();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _buildTestWidget(remoteAddressController: controller, formKey: formKey),
      );
      await tester.pumpAndSettle();

      // Validate when empty
      expect(formKey.currentState!.validate(), isFalse);
      await tester.pumpAndSettle();
      expect(find.text('Server url is required'), findsOneWidget);

      // Enter invalid URL
      final editables = find.byType(EditableText);
      await tester.enterText(editables.at(1), 'not a valid url here');
      await tester.pumpAndSettle();

      expect(formKey.currentState!.validate(), isFalse);
      await tester.pumpAndSettle();
      expect(
        find.text('Server url must be a valid http or https URL'),
        findsOneWidget,
      );

      // Enter valid URL
      await tester.enterText(editables.at(1), 'example.com/dav');
      await tester.pumpAndSettle();

      // Note: root path is also validated in the form group
      // Enter valid root path so entire form passes
      await tester.enterText(editables.at(2), '/dav');
      await tester.pumpAndSettle();

      expect(formKey.currentState!.validate(), isTrue);
    });
  });
}
