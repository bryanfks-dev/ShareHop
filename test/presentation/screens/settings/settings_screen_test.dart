import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/on_file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/presentation/screens/settings/screen.dart';
import 'package:sharehop/presentation/theme/theme.dart';

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
  testWidgets('SettingsScreen displays configuration and updates', (
    tester,
  ) async {
    final fakeRepo = FakeAppConfigRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigRepositoryProvider.overrideWithValue(fakeRepo),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
          home: const SettingsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify sections and values are rendered
    expect(find.text('TRANSFER PREFERENCES'), findsOneWidget);
    expect(find.text('Wi-Fi only transfers'), findsOneWidget);
    expect(find.text('Background transfers'), findsOneWidget);
    expect(find.text('Simultaneous transfers'), findsOneWidget);
    expect(find.text('4 transfers'), findsOneWidget);
    expect(find.text('File conflicts'), findsOneWidget);
    expect(find.text('Overwrite files'), findsOneWidget);

    expect(find.text('SECURITY'), findsOneWidget);
    expect(find.text('Biometric lock'), findsOneWidget);

    expect(find.text('STORAGE'), findsOneWidget);
    expect(find.text('Download destination'), findsOneWidget);
    expect(find.text('on /test/downloads'), findsOneWidget);
    expect(find.text('Clear cache'), findsOneWidget);

    expect(find.text('APP PREFERENCES'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);

    // Test tapping switch for Wi-Fi only
    await tester.tap(find.text('Wi-Fi only transfers'));
    await tester.pumpAndSettle();
    expect(fakeRepo.model.isWifiOnlyTransfersEnabled, isFalse);

    // Test changing simultaneous transfers limit
    await tester.tap(find.text('Simultaneous transfers'));
    await tester.pumpAndSettle();
    expect(find.text('Select simultaneous transfers limit'), findsOneWidget);
    expect(find.text('2 transfer(s)'), findsOneWidget);
    await tester.tap(find.text('2 transfer(s)'));
    await tester.pumpAndSettle();
    expect(fakeRepo.model.simultaneousTransfersLimit, 2);
    expect(find.text('2 transfers'), findsOneWidget);

    // Test changing file conflicts resolution
    await tester.tap(find.text('File conflicts'));
    await tester.pumpAndSettle();
    expect(find.text('Select file conflicts resolution'), findsOneWidget);
    await tester.tap(find.text('Skip files'));
    await tester.pumpAndSettle();
    expect(
      fakeRepo.model.onFileConflictsResolution,
      OnFileConflictsResolution.skip,
    );
    expect(find.text('Skip files'), findsOneWidget);

    // Test changing download destination
    await tester.tap(find.text('Download destination'));
    await tester.pumpAndSettle();
    expect(find.text('Download Destination'), findsOneWidget);
    await tester.enterText(find.byType(EditableText), '/new/path');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(fakeRepo.model.downloadDestinationPath, '/new/path');
    expect(find.text('on /new/path'), findsOneWidget);

    // Test clear cache confirmation sheet
    await tester.tap(find.text('Clear cache'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Are you sure you want to clear temporary cache files? '
        'This will free up memory and storage space.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();

    // Test changing app appearance
    await tester.tap(find.text('Appearance'));
    await tester.pumpAndSettle();
    expect(find.text('Select app appearance'), findsOneWidget);
    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();
    expect(fakeRepo.model.appAppearance, AppTheme.light);
    expect(find.text('Light'), findsOneWidget);
  });
}
