import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/use_cases/update_simultaneous_transfers_limit_use_case.dart';

class MockAppConfigRepository implements AppConfigRepository {
  int? updatedLimit;

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
  Future<void> setBiometricLockEnabled({required bool enabled}) =>
      throw UnimplementedError();

  @override
  Future<void> setDownloadPath({required String path}) =>
      throw UnimplementedError();

  @override
  Future<void> setFileConflictResolution({
    required FileConflictsResolution resolution,
  }) => throw UnimplementedError();

  @override
  Future<void> setMaxSimultaneousTransfers({required int limit}) async {
    updatedLimit = limit;
  }

  @override
  Future<void> setWifiOnlyTransfersEnabled({required bool enabled}) =>
      throw UnimplementedError();
}

void main() {
  group('UpdateSimultaneousTransfersLimitUseCase', () {
    test('updates simultaneous transfers limit via repository', () async {
      final repository = MockAppConfigRepository();
      final useCase = UpdateSimultaneousTransfersLimitUseCase(
        appConfigRepository: repository,
      );

      await useCase.call(limit: 5);
      expect(repository.updatedLimit, 5);
    });
  });
}
