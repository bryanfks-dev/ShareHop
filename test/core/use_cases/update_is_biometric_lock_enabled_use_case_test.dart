import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/use_cases/update_is_biometric_lock_enabled_use_case.dart';

class MockAppConfigRepository implements AppConfigRepository {
  bool? updatedEnabled;

  @override
  Future<AppConfigModel> getConfig() => throw UnimplementedError();

  @override
  Future<String> getEncryptionKey() => throw UnimplementedError();

  @override
  Future<void> setAppTheme({required AppTheme theme}) =>
      throw UnimplementedError();

  @override
  Future<void> setBackgroundTransfersEnabled({required bool enabled}) =>
      throw UnimplementedError();

  @override
  Future<void> setBiometricLockEnabled({required bool enabled}) async {
    updatedEnabled = enabled;
  }

  @override
  Future<void> setDownloadPath({required String path}) =>
      throw UnimplementedError();

  @override
  Future<void> setFileConflictResolution({
    required FileConflictsResolution resolution,
  }) => throw UnimplementedError();

  @override
  Future<void> setMaxSimultaneousTransfers({required int limit}) =>
      throw UnimplementedError();

  @override
  Future<void> setWifiOnlyTransfersEnabled({required bool enabled}) =>
      throw UnimplementedError();
}

void main() {
  group('UpdateIsBiometricLockEnabledUseCase', () {
    test('updates biometric lock enabled state via repository', () async {
      final repository = MockAppConfigRepository();
      final useCase = UpdateIsBiometricLockEnabledUseCase(
        appConfigRepository: repository,
      );

      await useCase.call(enabled: true);
      expect(repository.updatedEnabled, isTrue);

      await useCase.call(enabled: false);
      expect(repository.updatedEnabled, isFalse);
    });
  });
}
