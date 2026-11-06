import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/on_file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/gateways/biometric_lock_gateway.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/presentation/screens/settings/sections/security_section.dart';
import 'package:sharehop/presentation/screens/settings/widgets/confirmation_biometric_lock_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class FakeBiometricLockGateway implements BiometricLockGateway {
  new({
    this.isSupported = true,
    this.authenticatedResult = true,
  });

  bool isSupported;
  bool authenticatedResult;
  int authenticateUserCalls = 0;

  @override
  Future<bool> checkDeviceSupported() async => isSupported;

  @override
  Future<bool> authenticateUser({required String localizedMessage}) async {
    authenticateUserCalls++;
    return authenticatedResult;
  }
}

class FakeAppConfigRepository implements AppConfigRepository {
  AppConfigModel model = AppConfigModel(
    isWifiOnlyTransfersEnabled: true,
    isBackgroundTransfersEnabled: false,
    simultaneousTransfersLimit: 4,
    onFileConflictsResolution: OnFileConflictsResolution.overwrite,
    isBiometricLockEnabled: false,
    downloadDestinationPath: '/test/downloads',
    appAppearance: AppTheme.dark,
  );

  @override
  Future<AppConfigModel> getConfig() async => model;

  @override
  Future<void> setAppAppearance({required AppTheme theme}) async {
    model = model.copyWith(appAppearance: theme);
  }

  @override
  Future<void> setDownloadDestinationPath({required String path}) async {
    model = model.copyWith(downloadDestinationPath: path);
  }

  @override
  Future<void> setIsBackgroundTransfersEnabled({required bool enabled}) async {
    model = model.copyWith(isBackgroundTransfersEnabled: enabled);
  }

  @override
  Future<void> setIsBiometricLockEnabled({required bool enabled}) async {
    model = model.copyWith(isBiometricLockEnabled: enabled);
  }

  @override
  Future<void> setIsWifiOnlyTransfersEnabled({required bool enabled}) async {
    model = model.copyWith(isWifiOnlyTransfersEnabled: enabled);
  }

  @override
  Future<void> setOnFileConflictsResolution({
    required OnFileConflictsResolution resolution,
  }) async {
    model = model.copyWith(onFileConflictsResolution: resolution);
  }

  @override
  Future<void> setSimultaneousTransfersLimit({required int limit}) async {
    model = model.copyWith(simultaneousTransfersLimit: limit);
  }
}

void main() {
  testWidgets(
    'showConfirmationBiometricLockSheet renders and calls onProceed',
    (tester) async {
    var proceedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          ...FLocalizations.localizationsDelegates,
        ],
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: FToaster(child: child!),
        ),
        home: Builder(
          builder: (context) => Center(
            child: FButton(
              onPress: () => showConfirmationBiometricLockSheet(
                context,
                onProceed: () {
                  proceedCalled = true;
                },
              ),
              child: const Text('Open Sheet'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Sheet'));
    await tester.pumpAndSettle();

    expect(find.text('Biometric Lock'), findsOneWidget);
    expect(
      find.text(
        'Protect your connections and transferred files by requiring '
        'biometric authentication (Face ID, Touch ID, or fingerprint) '
        'each time you open ShareHop.',
      ),
      findsOneWidget,
    );
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Proceed'), findsOneWidget);

    await tester.tap(find.text('Proceed'));
    await tester.pumpAndSettle();

    expect(proceedCalled, isTrue);
    expect(find.text('Biometric Lock'), findsNothing);
  });

  testWidgets(
    'SecuritySection shows biometric lock sheet on enable and '
    'authenticates on proceed',
    (tester) async {
      final fakeRepo = FakeAppConfigRepository();
      final fakeBiometricService = FakeBiometricLockGateway();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appConfigRepositoryProvider.overrideWithValue(fakeRepo),
            biometricLockGatewayProvider.overrideWithValue(
              fakeBiometricService,
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              ...FLocalizations.localizationsDelegates,
            ],
            builder: (context, child) => FTheme(
              data: lightTheme,
              child: FToaster(child: child!),
            ),
            home: const Scaffold(
              body: SecuritySection(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('SECURITY'), findsOneWidget);
      expect(find.text('Biometric lock'), findsOneWidget);

      // Tap Biometric lock to enable it
      await tester.tap(find.text('Biometric lock'));
      await tester.pumpAndSettle();

      // Verify the description sheet is displayed
      expect(find.text('Biometric Lock'), findsOneWidget);
      expect(find.text('Proceed'), findsOneWidget);

      // Tap proceed
      await tester.tap(find.text('Proceed'));
      await tester.pumpAndSettle();

      // Verify biometric authentication was requested and enabled
      expect(fakeBiometricService.authenticateUserCalls, 1);
      expect(fakeRepo.model.isBiometricLockEnabled, isTrue);
    },
  );
}
