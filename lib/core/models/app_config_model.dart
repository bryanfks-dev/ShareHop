import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';

part 'app_config_model.freezed.dart';

@freezed
class AppConfigModel with _$AppConfigModel {
  new({
    bool? isWifiOnlyTransfersEnabled,
    bool? isBackgroundTransfersEnabled,
    int? simultaneousTransfersLimit,
    FileConflictsResolution? onFileConflictsResolution,
    bool? isBiometricLockEnabled,
    String? downloadDestinationPath,
    AppTheme? appAppearance,
  }) : isWifiOnlyTransfersEnabled = isWifiOnlyTransfersEnabled ?? true,
       isBackgroundTransfersEnabled = isBackgroundTransfersEnabled ?? true,
       simultaneousTransfersLimit = simultaneousTransfersLimit ?? 3,
       onFileConflictsResolution =
           onFileConflictsResolution ?? FileConflictsResolution.askeverytime,
       isBiometricLockEnabled = isBiometricLockEnabled ?? false,
       downloadDestinationPath = downloadDestinationPath ?? '/',
       appAppearance = appAppearance ?? AppTheme.system;

  final bool isWifiOnlyTransfersEnabled;
  final bool isBackgroundTransfersEnabled;
  final int simultaneousTransfersLimit;

  final FileConflictsResolution onFileConflictsResolution;

  final bool isBiometricLockEnabled;

  final String downloadDestinationPath;

  final AppTheme appAppearance;
}
