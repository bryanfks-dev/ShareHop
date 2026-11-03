import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/on_file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';

abstract interface class AppConfigRepository {
  Future<AppConfigModel> getConfig();
  Future<void> setIsWifiOnlyTransfersEnabled({required bool enabled});
  Future<void> setIsBackgroundTransfersEnabled({required bool enabled});
  Future<void> setSimultaneousTransfersLimit({required int limit});
  Future<void> setOnFileConflictsResolution({
    required OnFileConflictsResolution resolution,
  });
  Future<void> setIsBiometricLockEnabled({required bool enabled});
  Future<void> setDownloadDestinationPath({required String path});
  Future<void> setAppAppearance({required AppTheme theme});
}
