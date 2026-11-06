import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/base_enum.dart';
import 'package:sharehop/core/enums/on_file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';

class AppConfigRepositoryImpl implements AppConfigRepository {
  final _prefs = SharedPreferencesAsync();

  @override
  Future<AppConfigModel> getConfig() async {
    final [
      isWifiOnlyTransfersEnabled,
      isBackgroundTransfersEnabled,
      simultaneousTransfersLimit,
      onFileConflictResolution,
      isBiometricLockEnabled,
      downloadDestinationPath,
      appAppearance,
    ] = await Future.wait([
      _prefs.getBool('isWifiOnlyTransfersEnabled'),
      _prefs.getBool('isBackgroundTransfersEnabled'),
      _prefs.getInt('simultaneousTransfersLimit'),
      _prefs.getString('onFileConflictsResolution'),
      _prefs.getBool('isBiometricLockEnabled'),
      _prefs.getString('downloadDestinationPath'),
      _prefs.getString('appAppearance'),
    ]);
    return AppConfigModel(
      isWifiOnlyTransfersEnabled: isWifiOnlyTransfersEnabled as bool?,
      isBackgroundTransfersEnabled: isBackgroundTransfersEnabled as bool?,
      simultaneousTransfersLimit: simultaneousTransfersLimit as int?,
      onFileConflictsResolution: onFileConflictResolution is String
          ? OnFileConflictsResolution.values.fromPersistentValue(
              onFileConflictResolution,
            )
          : null,
      isBiometricLockEnabled: isBiometricLockEnabled as bool?,
      downloadDestinationPath: downloadDestinationPath as String?,
      appAppearance: appAppearance is String
          ? AppTheme.values.fromPersistentValue(appAppearance)
          : null,
    );
  }

  @override
  Future<void> setIsWifiOnlyTransfersEnabled({required bool enabled}) async {
    return await _prefs.setBool('isWifiOnlyTransfersEnabled', enabled);
  }

  @override
  Future<void> setIsBackgroundTransfersEnabled({required bool enabled}) async {
    return await _prefs.setBool('isBackgroundTransfersEnabled', enabled);
  }

  @override
  Future<void> setSimultaneousTransfersLimit({required int limit}) async {
    return await _prefs.setInt('simultaneousTransfersLimit', limit);
  }

  @override
  Future<void> setOnFileConflictsResolution({
    required OnFileConflictsResolution resolution,
  }) async {
    return await _prefs.setString(
      'onFileConflictsResolution',
      resolution.persistentValue,
    );
  }

  @override
  Future<void> setIsBiometricLockEnabled({required bool enabled}) async {
    return await _prefs.setBool('isBiometricLockEnabled', enabled);
  }

  @override
  Future<void> setDownloadDestinationPath({required String path}) async {
    return await _prefs.setString('downloadDestinationPath', path);
  }

  @override
  Future<void> setAppAppearance({required AppTheme theme}) async {
    return await _prefs.setString('appAppearance', theme.persistentValue);
  }
}
