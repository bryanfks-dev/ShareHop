import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/forms/web_dav/credential_group.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(
      body: SingleChildScrollView(child: child),
    ),
  );
}

void main() {
  group('WebDavFormCredentialGroup', () {
    testWidgets('renders username and password input fields', (tester) async {
      final userCtrl = TextEditingController();
      final passCtrl = TextEditingController();

      await tester.pumpWidget(
        _buildTestWidget(
          WebDavFormCredentialGroup(
            usernameController: userCtrl,
            passwordController: passCtrl,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password or app password'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.user), findsOneWidget);
      expect(find.byIcon(FLucideIcons.keyRound), findsOneWidget);

      final editables = find.byType(EditableText);
      await tester.enterText(editables.first, 'myuser');
      expect(userCtrl.text, 'myuser');

      await tester.enterText(editables.last, 'mypass');
      expect(passCtrl.text, 'mypass');

      userCtrl.dispose();
      passCtrl.dispose();
    });
  });
}
