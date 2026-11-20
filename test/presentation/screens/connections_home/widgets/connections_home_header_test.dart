import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connections_home/widgets/connections_home_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

void main() {
  group('ConnectionsHomeHeader', () {
    testWidgets('renders title, subtitle, and logo', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const ConnectionsHomeHeader(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('ShareHop'), findsOneWidget);
      expect(find.text('Transfer files seamlessly'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.arrowLeftRight), findsOneWidget);
    });
  });
}
