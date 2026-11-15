import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/use_cases/get_app_config_use_case.dart';

class MockAppConfigRepository implements AppConfigRepository {
  AppConfigModel config = AppConfigModel(
    isWifiOnlyTransfersEnabled: true,
    isBackgroundTransfersEnabled: true,
    simultaneousTransfersLimit: 3,
    onFileConflictsResolution: FileConflictsResolution.askeverytime,
    isBiometricLockEnabled: false,
    downloadDestinationPath: '/downloads',
    appAppearance: AppTheme.system,
  );

  @override
  Future<AppConfigModel> getConfig() async => config;

  @override
  Future<String> getEncryptionKey() async => 'test-key';

  @override
  Future<void> setAppTheme({required AppTheme theme}) async {}

  @override
  Future<void> setBackgroundTransfersEnabled({required bool enabled}) async {}

  @override
  Future<void> setBiometricLockEnabled({required bool enabled}) async {}

  @override
  Future<void> setDownloadPath({required String path}) async {}

  @override
  Future<void> setFileConflictResolution({
    required FileConflictsResolution resolution,
  }) async {}

  @override
  Future<void> setMaxSimultaneousTransfers({required int limit}) async {}

  @override
  Future<void> setWifiOnlyTransfersEnabled({required bool enabled}) async {}
}

void main() {
  group('GetAppConfigUseCase', () {
    test('returns app configuration from repository', () async {
      final repository = MockAppConfigRepository();
      final useCase = GetAppConfigUseCase(appConfigRepository: repository);

      final result = await useCase.call();

      expect(result.downloadDestinationPath, '/downloads');
      expect(result.simultaneousTransfersLimit, 3);
      expect(result.isWifiOnlyTransfersEnabled, isTrue);
    });
  });
}
