import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';

abstract interface class AppConfigRepository {
  Future<AppConfigModel> getConfig();
  Future<String> getEncryptionKey();
  Future<void> setWifiOnlyTransfersEnabled({required bool enabled});
  Future<void> setBackgroundTransfersEnabled({required bool enabled});
  Future<void> setMaxSimultaneousTransfers({required int limit});
  Future<void> setFileConflictResolution({
    required FileConflictsResolution resolution,
  });
  Future<void> setBiometricLockEnabled({required bool enabled});
  Future<void> setDownloadPath({required String path});
  Future<void> setAppTheme({required AppTheme theme});
}
