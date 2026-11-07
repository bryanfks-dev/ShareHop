import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/base_enum.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/security/secure_random.dart';
import 'package:sharehop/infrastructures/security/secure_random_impl.dart';

class AppConfigRepositoryImpl implements AppConfigRepository {
  new({
    this.secureRandom = const SecureRandomImpl(),
    SharedPreferencesAsync? prefs,
    FlutterSecureStorage? secureStorage,
  }) : _prefs = prefs ?? SharedPreferencesAsync(),
       _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final SecureRandom secureRandom;
  final SharedPreferencesAsync _prefs;
  final FlutterSecureStorage _secureStorage;

  static const _kEncryptionKeyStorageKey = 'encryption_key';

  Future<String>? _encryptionKeyFuture;

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
      _,
    ] = await Future.wait([
      _prefs.getBool('isWifiOnlyTransfersEnabled'),
      _prefs.getBool('isBackgroundTransfersEnabled'),
      _prefs.getInt('simultaneousTransfersLimit'),
      _prefs.getString('onFileConflictsResolution'),
      _prefs.getBool('isBiometricLockEnabled'),
      _prefs.getString('downloadDestinationPath'),
      _prefs.getString('appAppearance'),
      getEncryptionKey(),
    ]);
    return AppConfigModel(
      isWifiOnlyTransfersEnabled: isWifiOnlyTransfersEnabled as bool?,
      isBackgroundTransfersEnabled: isBackgroundTransfersEnabled as bool?,
      simultaneousTransfersLimit: simultaneousTransfersLimit as int?,
      onFileConflictsResolution: onFileConflictResolution is String
          ? FileConflictsResolution.values.fromPersistentValue(
              value: onFileConflictResolution,
            )
          : null,
      isBiometricLockEnabled: isBiometricLockEnabled as bool?,
      downloadDestinationPath: downloadDestinationPath as String?,
      appAppearance: appAppearance is String
          ? AppTheme.values.fromPersistentValue(value: appAppearance)
          : null,
    );
  }

  @override
  Future<String> getEncryptionKey() {
    return _encryptionKeyFuture ??= _getOrGenerateEncryptionKey();
  }

  Future<String> _getOrGenerateEncryptionKey() async {
    try {
      final existingKey = await _secureStorage.read(
        key: _kEncryptionKeyStorageKey,
      );
      if (existingKey != null && existingKey.isNotEmpty) {
        return existingKey;
      }

      final newKey = secureRandom.generateKey();
      await _secureStorage.write(key: _kEncryptionKeyStorageKey, value: newKey);
      return newKey;
    } catch (_) {
      _encryptionKeyFuture = null;
      rethrow;
    }
  }

  @override
  Future<void> setWifiOnlyTransfersEnabled({required bool enabled}) async {
    return await _prefs.setBool('isWifiOnlyTransfersEnabled', enabled);
  }

  @override
  Future<void> setBackgroundTransfersEnabled({required bool enabled}) async {
    return await _prefs.setBool('isBackgroundTransfersEnabled', enabled);
  }

  @override
  Future<void> setMaxSimultaneousTransfers({required int limit}) async {
    return await _prefs.setInt('simultaneousTransfersLimit', limit);
  }

  @override
  Future<void> setFileConflictResolution({
    required FileConflictsResolution resolution,
  }) async {
    return await _prefs.setString(
      'onFileConflictsResolution',
      resolution.persistentValue,
    );
  }

  @override
  Future<void> setBiometricLockEnabled({required bool enabled}) async {
    return await _prefs.setBool('isBiometricLockEnabled', enabled);
  }

  @override
  Future<void> setDownloadPath({required String path}) async {
    return await _prefs.setString('downloadDestinationPath', path);
  }

  @override
  Future<void> setAppTheme({required AppTheme theme}) async {
    return await _prefs.setString('appAppearance', theme.persistentValue);
  }
}
