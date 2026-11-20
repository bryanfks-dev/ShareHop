import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/forms/web_dav/form.dart';

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
  group('WebDavForm', () {
    testWidgets('renders initial values and form fields properly', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const WebDavForm(
            initialDisplayName: 'Test Server',
            initialRemoteAddress: 'https://test.dav.io',
            initialRootPath: '/remote',
            initialUsername: 'tester',
            initialPassword: 'secretpassword',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Server'), findsOneWidget);
      expect(find.text('https://'), findsOneWidget);
      expect(find.text('test.dav.io'), findsOneWidget);
      expect(find.text('/remote'), findsOneWidget);
      expect(find.text('tester'), findsOneWidget);
      expect(find.text('secretpassword'), findsOneWidget);
      expect(find.text('Save connection'), findsOneWidget);
    });

    testWidgets('validates required fields on save press when empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const WebDavForm(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Save connection'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save connection'));
      await tester.pumpAndSettle();

      expect(find.text('Server url is required'), findsOneWidget);
      expect(
        find.text('Password or app password is required'),
        findsOneWidget,
      );
    });
  });
}
