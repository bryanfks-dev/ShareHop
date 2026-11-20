import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/forms/web_dav/security_group.dart';

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
  group('WebDavFormSecurityGroup', () {
    testWidgets('renders authentication method tabs and security options', (
      tester,
    ) async {
      final tabCtrl = FTabController(
        length: kWebDavFormSecurityAuthenticationMethods.length,
        vsync: const TestVSync(),
      );

      var validateCert = true;
      var allowSelfSigned = false;

      await tester.pumpWidget(
        _buildTestWidget(
          WebDavFormSecurityGroup(
            authenticationMethodTabController: tabCtrl,
            validateCertificate: validateCert,
            allowSelfSigned: allowSelfSigned,
            onChangeValidateCertificate: (val) => validateCert = val,
            onChangeAllowSelfSigned: (val) => allowSelfSigned = val,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Authentication method'), findsOneWidget);
      expect(find.text('Auto'), findsOneWidget);
      expect(find.text('Basic'), findsOneWidget);
      expect(find.text('Digest'), findsOneWidget);
      expect(find.text('Validate server certificate'), findsOneWidget);
      expect(find.text('Allow self-signed certificate'), findsOneWidget);

      await tester.tap(find.text('Validate server certificate'));
      await tester.pumpAndSettle();
      expect(validateCert, isFalse);

      await tester.tap(find.text('Allow self-signed certificate'));
      await tester.pumpAndSettle();
      expect(allowSelfSigned, isTrue);

      tabCtrl.dispose();
    });
  });
}
