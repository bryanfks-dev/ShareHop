import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/gateways/biometric_lock_gateway.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/presentation/screens/splash/screen.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_footer.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_locked_footer.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_logo.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/layout/main_shell.dart';

class FakeBiometricLockGateway implements BiometricLockGateway {
  new({
    this.isSupported = true,
    this.authenticatedResult = true,
    this.completer,
  });

  bool isSupported;
  bool authenticatedResult;
  Completer<bool>? completer;
  int authenticateUserCalls = 0;

  @override
  Future<bool> checkDeviceSupported() async => isSupported;

  @override
  Future<bool> authenticateUser({required String localizedMessage}) async {
    authenticateUserCalls++;
    if (completer != null) {
      return await completer!.future;
    }
    return authenticatedResult;
  }
}

class FakeAppConfigRepository implements AppConfigRepository {
  new({AppConfigModel? initial})
      : model = initial ??
            AppConfigModel(
              isWifiOnlyTransfersEnabled: true,
              isBackgroundTransfersEnabled: false,
              simultaneousTransfersLimit: 4,
              onFileConflictsResolution: FileConflictsResolution.overwrite,
              isBiometricLockEnabled: false,
              downloadDestinationPath: '/test/downloads',
              appAppearance: AppTheme.dark,
            );

  AppConfigModel model;

  @override
  Future<AppConfigModel> getConfig() async => model;

  @override
  Future<String> getEncryptionKey() async => 'test-key';

  @override
  Future<void> setAppTheme({required AppTheme theme}) async {
    model = model.copyWith(appAppearance: theme);
  }

  @override
  Future<void> setDownloadPath({required String path}) async {
    model = model.copyWith(downloadDestinationPath: path);
  }

  @override
  Future<void> setBackgroundTransfersEnabled({required bool enabled}) async {
    model = model.copyWith(isBackgroundTransfersEnabled: enabled);
  }

  @override
  Future<void> setBiometricLockEnabled({required bool enabled}) async {
    model = model.copyWith(isBiometricLockEnabled: enabled);
  }

  @override
  Future<void> setWifiOnlyTransfersEnabled({required bool enabled}) async {
    model = model.copyWith(isWifiOnlyTransfersEnabled: enabled);
  }

  @override
  Future<void> setFileConflictResolution({
    required FileConflictsResolution resolution,
  }) async {
    model = model.copyWith(onFileConflictsResolution: resolution);
  }

  @override
  Future<void> setMaxSimultaneousTransfers({required int limit}) async {
    model = model.copyWith(simultaneousTransfersLimit: limit);
  }
}

Widget _buildTestWidget(
  Widget child, {
  FakeAppConfigRepository? appConfigRepo,
  FakeBiometricLockGateway? biometricService,
}) {
  return ProviderScope(
    overrides: [
      if (appConfigRepo != null)
        appConfigRepositoryProvider.overrideWithValue(appConfigRepo),
      if (biometricService != null)
        biometricLockGatewayProvider.overrideWithValue(biometricService),
    ],
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

    testWidgets(
      'when biometric lock is enabled and authentication succeeds, '
      'verifies biometric and navigates to MainShell',
      (tester) async {
        final fakeBiometricService = FakeBiometricLockGateway();
        final fakeRepo = FakeAppConfigRepository(
          initial: AppConfigModel(
            isWifiOnlyTransfersEnabled: true,
            isBackgroundTransfersEnabled: false,
            simultaneousTransfersLimit: 4,
            onFileConflictsResolution: FileConflictsResolution.overwrite,
            isBiometricLockEnabled: true,
            downloadDestinationPath: '/test/downloads',
            appAppearance: AppTheme.dark,
          ),
        );

        await tester.pumpWidget(
          _buildTestWidget(
            const SplashScreen(),
            appConfigRepo: fakeRepo,
            biometricService: fakeBiometricService,
          ),
        );

        expect(find.byType(SplashScreen), findsOneWidget);
        expect(fakeBiometricService.authenticateUserCalls, 0);

        // Advance past splash duration
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        expect(fakeBiometricService.authenticateUserCalls, 1);
        expect(find.byType(MainShell), findsOneWidget);
      },
    );

    testWidgets(
      'when biometric lock is enabled and authentication fails, '
      'stays on locked screen and displays unlock button',
      (tester) async {
        final fakeBiometricService =
            FakeBiometricLockGateway(authenticatedResult: false);
        final fakeRepo = FakeAppConfigRepository(
          initial: AppConfigModel(
            isWifiOnlyTransfersEnabled: true,
            isBackgroundTransfersEnabled: false,
            simultaneousTransfersLimit: 4,
            onFileConflictsResolution: FileConflictsResolution.overwrite,
            isBiometricLockEnabled: true,
            downloadDestinationPath: '/test/downloads',
            appAppearance: AppTheme.dark,
          ),
        );

        await tester.pumpWidget(
          _buildTestWidget(
            const SplashScreen(),
            appConfigRepo: fakeRepo,
            biometricService: fakeBiometricService,
          ),
        );

        // Advance past splash duration
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        expect(fakeBiometricService.authenticateUserCalls, 1);
        expect(find.byType(MainShell), findsNothing);
        expect(find.byType(SplashLockedFooter), findsOneWidget);
        expect(find.text('Unlock ShareHop'), findsOneWidget);

        // Tap unlock button when authentication will now succeed
        fakeBiometricService.authenticatedResult = true;
        await tester.tap(find.text('Unlock ShareHop'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        expect(fakeBiometricService.authenticateUserCalls, 2);
        expect(find.byType(MainShell), findsOneWidget);
      },
    );

    testWidgets(
      'displays loading indicator on unlock button while authentication '
      'is in progress',
      (tester) async {
        final completer = Completer<bool>();
        final fakeBiometricService =
            FakeBiometricLockGateway(authenticatedResult: false);
        final fakeRepo = FakeAppConfigRepository(
          initial: AppConfigModel(
            isWifiOnlyTransfersEnabled: true,
            isBackgroundTransfersEnabled: false,
            simultaneousTransfersLimit: 4,
            onFileConflictsResolution: FileConflictsResolution.overwrite,
            isBiometricLockEnabled: true,
            downloadDestinationPath: '/test/downloads',
            appAppearance: AppTheme.dark,
          ),
        );

        await tester.pumpWidget(
          _buildTestWidget(
            const SplashScreen(),
            appConfigRepo: fakeRepo,
            biometricService: fakeBiometricService,
          ),
        );

        // Advance past splash duration to reach locked state
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        expect(fakeBiometricService.authenticateUserCalls, 1);
        expect(find.byType(SplashLockedFooter), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(SplashLockedFooter),
            matching: find.byIcon(FLucideIcons.lock),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(SplashLockedFooter),
            matching: find.byType(FCircularProgress),
          ),
          findsNothing,
        );

        // Set completer so authenticateUser awaits
        fakeBiometricService.completer = completer;

        // Tap unlock button
        await tester.tap(find.text('Unlock ShareHop'));
        await tester.pump();

        // While authenticating, button shows FCircularProgress and no lock icon
        expect(fakeBiometricService.authenticateUserCalls, 2);
        expect(
          find.descendant(
            of: find.byType(SplashLockedFooter),
            matching: find.byType(FCircularProgress),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(SplashLockedFooter),
            matching: find.byIcon(FLucideIcons.lock),
          ),
          findsNothing,
        );

        // Tapping while loading does not trigger another call
        await tester.tap(find.text('Unlock ShareHop'));
        await tester.pump();
        expect(fakeBiometricService.authenticateUserCalls, 2);

        // Complete authentication
        completer.complete(true);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byType(MainShell), findsOneWidget);
      },
    );
  });

  group('SplashLockedFooter', () {
    testWidgets('renders lock icon and calls onPressUnlock when tapped',
        (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        _buildTestWidget(
          SplashLockedFooter(
            onPressUnlock: () => pressed = true,
          ),
        ),
      );

      expect(find.text('Unlock ShareHop'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.lock), findsOneWidget);
      expect(find.byType(FCircularProgress), findsNothing);

      await tester.tap(find.text('Unlock ShareHop'));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets(
      'renders FCircularProgress and disables onPress when isLoading is true',
      (tester) async {
        var pressed = false;
        await tester.pumpWidget(
          _buildTestWidget(
            SplashLockedFooter(
              isLoading: true,
              onPressUnlock: () => pressed = true,
            ),
          ),
        );

        expect(find.text('Unlock ShareHop'), findsOneWidget);
        expect(find.byIcon(FLucideIcons.lock), findsNothing);
        expect(find.byType(FCircularProgress), findsOneWidget);

        await tester.tap(find.text('Unlock ShareHop'));
        await tester.pump(const Duration(milliseconds: 200));

        expect(pressed, isFalse);
      },
    );
  });
}
