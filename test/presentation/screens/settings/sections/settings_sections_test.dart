import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/gateways/biometric_lock_gateway.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/presentation/screens/settings/sections/app_preferences_section.dart';
import 'package:sharehop/presentation/screens/settings/sections/security_section.dart';
import 'package:sharehop/presentation/screens/settings/sections/storage_section.dart';
import 'package:sharehop/presentation/screens/settings/sections/transfer_preferences_section.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class _FakeAppConfigRepository implements AppConfigRepository {
  AppConfigModel model = AppConfigModel(
    isWifiOnlyTransfersEnabled: true,
    isBackgroundTransfersEnabled: false,
    simultaneousTransfersLimit: 3,
    onFileConflictsResolution: FileConflictsResolution.askeverytime,
    isBiometricLockEnabled: false,
    downloadDestinationPath: '/downloads/test',
    appAppearance: AppTheme.system,
  );

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

class _FakeBiometricLockGateway implements BiometricLockGateway {
  bool supported = true;
  bool authenticateResult = true;

  @override
  Future<bool> checkDeviceSupported() async => supported;

  @override
  Future<bool> authenticateUser({required String localizedMessage}) async =>
      authenticateResult;
}

Widget _buildTestWidget({
  required Widget child,
  required _FakeAppConfigRepository repo,
  required _FakeBiometricLockGateway biometricGateway,
}) {
  return ProviderScope(
    overrides: [
      appConfigRepositoryProvider.overrideWithValue(repo),
      biometricLockGatewayProvider.overrideWithValue(biometricGateway),
    ],
    child: MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: Scaffold(
        body: SingleChildScrollView(child: child),
      ),
    ),
  );
}

void main() {
  group('Settings Sections', () {
    late _FakeAppConfigRepository repo;
    late _FakeBiometricLockGateway biometricGateway;

    setUp(() {
      repo = _FakeAppConfigRepository();
      biometricGateway = _FakeBiometricLockGateway();
    });

    testWidgets('AppPreferencesSection renders and shows appearance label', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const AppPreferencesSection(),
          repo: repo,
          biometricGateway: biometricGateway,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('App Preferences'), findsOneWidget);
      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('System'), findsOneWidget);
    });

    testWidgets('StorageSection renders and shows download path', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const StorageSection(),
          repo: repo,
          biometricGateway: biometricGateway,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Storage'), findsOneWidget);
      expect(find.text('Download destination'), findsOneWidget);
      expect(find.text('on /downloads/test'), findsOneWidget);
      expect(find.text('Clear cache'), findsOneWidget);
    });

    testWidgets('SecuritySection renders biometric lock switch', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const SecuritySection(),
          repo: repo,
          biometricGateway: biometricGateway,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Security'), findsOneWidget);
      expect(find.text('Biometric lock'), findsOneWidget);
      expect(find.byType(FSwitch), findsOneWidget);
    });

    testWidgets('TransferPreferencesSection renders transfer settings', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          child: const TransferPreferencesSection(),
          repo: repo,
          biometricGateway: biometricGateway,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Transfer Preferences'), findsOneWidget);
      expect(find.text('Wi-Fi only transfers'), findsOneWidget);
      expect(find.text('Simultaneous transfers'), findsOneWidget);
      expect(find.text('3 transfers'), findsOneWidget);
      expect(find.text('File conflicts'), findsOneWidget);
      expect(find.text('Ask every time'), findsOneWidget);
    });
  });
}
