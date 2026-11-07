import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/splash/screen.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_footer.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_logo.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: child,
    ),
  );
}

void main() {
  group('SplashScreen', () {
    testWidgets('renders logo, title, subtitle, and footer', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const SplashScreen()));

      expect(find.byType(SplashLogo), findsOneWidget);
      expect(find.byType(SplashFooter), findsOneWidget);
      expect(find.text('ShareHop'), findsOneWidget);
      expect(find.text('Transfer files seamlessly'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.arrowLeftRight), findsOneWidget);
      expect(find.byType(FCircularProgress), findsOneWidget);

      await tester.pump(const Duration(seconds: 10));
      await tester.pumpAndSettle();
    });
  });
}
