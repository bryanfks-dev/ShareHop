import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/add_connection/screen.dart';
import 'package:sharehop/presentation/screens/connections_home/widgets/quick_connect_text_field.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget() {
  return ProviderScope(
    child: MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: const Scaffold(
        body: QuickConnectTextField(),
      ),
    ),
  );
}

void main() {
  group('QuickConnectTextField', () {
    testWidgets(
      'tapping Connect with empty text navigates to AddConnectionScreen',
      (tester) async {
        await tester.pumpWidget(_buildTestWidget());
        await tester.pumpAndSettle();

        final connectButton = find.text('Connect');
        expect(connectButton, findsOneWidget);

        await tester.tap(connectButton);
        await tester.pumpAndSettle();

        expect(find.byType(AddConnectionScreen), findsOneWidget);
      },
    );

    testWidgets(
      'entering server address and tapping Connect pre-fills server URL in '
      'AddConnectionScreen',
      (tester) async {
        await tester.pumpWidget(_buildTestWidget());
        await tester.pumpAndSettle();

        final textField = find.byType(FTextField);
        expect(textField, findsOneWidget);

        await tester.enterText(textField, 'dav.myhost.com');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Connect'));
        await tester.pumpAndSettle();

        expect(find.byType(AddConnectionScreen), findsOneWidget);
        expect(find.text('https://'), findsWidgets);
        expect(find.text('dav.myhost.com'), findsWidgets);
      },
    );

    testWidgets(
      'submitting keyboard on QuickConnectTextField navigates to '
      'AddConnectionScreen',
      (tester) async {
        await tester.pumpWidget(_buildTestWidget());
        await tester.pumpAndSettle();

        final textField = find.byType(FTextField);
        await tester.enterText(textField, 'https://storage.cloud.org/files');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(find.byType(AddConnectionScreen), findsOneWidget);
        expect(find.text('https://'), findsWidgets);
        expect(find.text('storage.cloud.org/files'), findsOneWidget);
      },
    );

    testWidgets(
      'entering WebDAV URI with credentials pre-fills address, username and '
      'password',
      (tester) async {
        await tester.pumpWidget(_buildTestWidget());
        await tester.pumpAndSettle();

        final textField = find.byType(FTextField);
        await tester.enterText(
          textField,
          'webdav://alice:secret123@dav.box.com/remote.php/webdav',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Connect'));
        await tester.pumpAndSettle();

        expect(find.byType(AddConnectionScreen), findsOneWidget);
        expect(find.text('http://'), findsWidgets);
        expect(find.text('dav.box.com/remote.php/webdav'), findsOneWidget);
        expect(find.text('alice'), findsOneWidget);
        expect(find.text('secret123'), findsOneWidget);
      },
    );

    testWidgets(
      'entering SFTP URI navigates to AddConnectionScreen with SFTP selected',
      (tester) async {
        await tester.pumpWidget(_buildTestWidget());
        await tester.pumpAndSettle();

        final textField = find.byType(FTextField);
        await tester.enterText(textField, 'sftp://ssh.server.com');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Connect'));
        await tester.pumpAndSettle();

        expect(find.byType(AddConnectionScreen), findsOneWidget);
        expect(find.text('SFTP is not supported yet'), findsOneWidget);
      },
    );
  });
}
