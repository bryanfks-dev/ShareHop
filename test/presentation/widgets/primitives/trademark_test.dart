import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/models/app_info_model.dart';
import 'package:sharehop/presentation/controllers/app_info_controller.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/primitives/trademark.dart';

void main() {
  Widget buildTestWidget({List<dynamic> overrides = const []}) {
    return ProviderScope(
      overrides: overrides.cast(),
      child: MaterialApp(
        localizationsDelegates: const [
          ...FLocalizations.localizationsDelegates,
        ],
        builder: (context, c) => FTheme(data: lightTheme, child: c!),
        home: const Scaffold(body: Center(child: Trademark())),
      ),
    );
  }

  group('Trademark', () {
    testWidgets('renders appInfo display string when loaded', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          overrides: [
            appInfoControllerProvider.overrideWith(
              () => _TestAppInfoController(
                const AsyncData(
                  AppInfoModel(version: '2.1.0', buildNumber: '99'),
                ),
              ),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('ShareHop 2.1.0 (99) · Made by bryanfks'),
        findsOneWidget,
      );
    });

    testWidgets('renders fallback text on error', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          overrides: [
            appInfoControllerProvider.overrideWith(
              () => _TestAppInfoController(
                AsyncError(Exception('error'), StackTrace.empty),
              ),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('ShareHop 1.0.0 (1) · Made by bryanfks'),
        findsOneWidget,
      );
    });
  });
}

class _TestAppInfoController extends AppInfoController {
  new(this._initialState);

  final AsyncValue<AppInfoModel> _initialState;

  @override
  Future<AppInfoModel> build() async {
    return _initialState.requireValue;
  }
}
