import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/models/app_info_model.dart';
import 'package:sharehop/presentation/controllers/app_info_controller.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_footer.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_locked_footer.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_logo.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return ProviderScope(
      overrides: [
        appInfoControllerProvider.overrideWith(
          () => _TestAppInfoController(
            const AsyncData(
              AppInfoModel(version: '1.0.0', buildNumber: '1'),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          ...FLocalizations.localizationsDelegates,
        ],
        builder: (context, c) => FTheme(data: lightTheme, child: c!),
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  group('Splash widgets', () {
    testWidgets('SplashLogo renders brand title and subtitle', (tester) async {
      await tester.pumpWidget(buildTestWidget(const SplashLogo()));
      await tester.pumpAndSettle();

      expect(find.text('ShareHop'), findsOneWidget);
      expect(find.text('Transfer files seamlessly'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.arrowLeftRight), findsOneWidget);
    });

    testWidgets('SplashFooter renders progress indicator and trademark', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(const SplashFooter()));
      await tester.pump();

      expect(find.byType(FCircularProgress), findsOneWidget);
      expect(
        find.text('ShareHop 1.0.0 (1) · Made by bryanfks'),
        findsOneWidget,
      );
    });

    testWidgets('SplashLockedFooter renders unlock button and calls action', (
      tester,
    ) async {
      var isUnlockPressed = false;

      await tester.pumpWidget(
        buildTestWidget(
          SplashLockedFooter(onPressUnlock: () => isUnlockPressed = true),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Unlock ShareHop'), findsOneWidget);

      await tester.tap(find.text('Unlock ShareHop'));
      await tester.pumpAndSettle();

      expect(isUnlockPressed, isTrue);
    });

    testWidgets('SplashLockedFooter renders loading indicator when isLoading', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          SplashLockedFooter(onPressUnlock: () {}, isLoading: true),
        ),
      );
      await tester.pump();

      expect(find.byType(FCircularProgress), findsOneWidget);
    });
  });
}

class _TestAppInfoController extends AppInfoController {
  new(this._initialState);

  final AsyncValue<AppInfoModel> _initialState;

  @override
  Future<AppInfoModel> build() async => _initialState.requireValue;
}
