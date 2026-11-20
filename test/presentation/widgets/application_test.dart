import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/presentation/controllers/settings_controller.dart';
import 'package:sharehop/presentation/screens/splash/screen.dart';
import 'package:sharehop/presentation/widgets/application.dart';

void main() {
  group('Application', () {
    testWidgets('renders MaterialApp with SplashScreen as home', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsControllerProvider.overrideWith(
              () => _TestSettingsController(
                AsyncData(
                  AppConfigModel(appAppearance: AppTheme.light),
                ),
              ),
            ),
          ],
          child: const Application(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SplashScreen), findsOneWidget);
    });

    testWidgets('adapts to dark theme', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsControllerProvider.overrideWith(
              () => _TestSettingsController(
                AsyncData(
                  AppConfigModel(appAppearance: AppTheme.dark),
                ),
              ),
            ),
          ],
          child: const Application(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SplashScreen), findsOneWidget);
    });
  });
}

class _TestSettingsController extends SettingsController {
  new(this._initialState);

  final AsyncValue<AppConfigModel> _initialState;

  @override
  Future<AppConfigModel> build() async {
    return _initialState.requireValue;
  }
}
