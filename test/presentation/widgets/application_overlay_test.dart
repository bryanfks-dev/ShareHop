import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/presentation/controllers/settings_controller.dart';
import 'package:sharehop/presentation/widgets/application_overlay.dart';

void main() {
  group('ApplicationOverlay', () {
    testWidgets('renders child in transparent MaterialApp container', (
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
          child: const ApplicationOverlay(
            child: Text('Overlay Child Content'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Overlay Child Content'), findsOneWidget);
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
