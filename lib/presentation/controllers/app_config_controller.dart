import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/on_file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/di/app_config_di.dart';

part 'app_config_controller.g.dart';

@Riverpod(keepAlive: true)
class AppConfigController extends _$AppConfigController {
  @override
  Future<AppConfigModel> build() async =>
      await ref.watch(getAppConfigUseCaseProvider)();

  Future<void> setIsWifiOnlyTransfersEnabled({required bool enabled}) async {
    final current = state.value;
    if (current == null) {
      return;
    }

    final previous = state;
    state = AsyncData(current.copyWith(isWifiOnlyTransfersEnabled: enabled));

    try {
      await ref
          .read(setIsWifiOnlyTransfersEnabledUseCaseProvider)
          .call(enabled: enabled);
    } on Exception {
      state = previous;
    }
  }

  Future<void> setIsBackgroundTransfersEnabled({required bool enabled}) async {
    final current = state.value;
    if (current == null) {
      return;
    }

    final previous = state;
    state = AsyncData(current.copyWith(isBackgroundTransfersEnabled: enabled));

    try {
      await ref
          .read(setIsBackgroundTransfersEnabledUseCaseProvider)
          .call(enabled: enabled);
    } on Exception {
      state = previous;
    }
  }

  Future<void> setSimultaneousTransfersLimit({required int limit}) async {
    final current = state.value;
    if (current == null) {
      return;
    }

    final previous = state;
    state = AsyncData(current.copyWith(simultaneousTransfersLimit: limit));

    try {
      await ref
          .read(setSimultaneousTransfersLimitUseCaseProvider)
          .call(limit: limit);
    } on Exception {
      state = previous;
    }
  }

  Future<void> setOnFileConflictsResolution({
    required OnFileConflictsResolution resolution,
  }) async {
    final current = state.value;
    if (current == null) {
      return;
    }

    final previous = state;
    state = AsyncData(current.copyWith(onFileConflictsResolution: resolution));

    try {
      await ref
          .read(setOnFileConflictsResolutionUseCaseProvider)
          .call(resolution: resolution);
    } on Exception {
      state = previous;
    }
  }

  Future<void> setIsBiometricLockEnabled({required bool enabled}) async {
    final current = state.value;
    if (current == null) {
      return;
    }

    final previous = state;
    state = AsyncData(current.copyWith(isBiometricLockEnabled: enabled));

    try {
      await ref
          .read(setIsBiometricLockEnabledUseCaseProvider)
          .call(enabled: enabled);
    } on Exception {
      state = previous;
    }
  }

  Future<void> setDownloadDestinationPath({required String path}) async {
    final current = state.value;
    if (current == null) {
      return;
    }

    final previous = state;
    state = AsyncData(current.copyWith(downloadDestinationPath: path));

    try {
      await ref
          .read(setDownloadDestinationPathUseCaseProvider)
          .call(path: path);
    } on Exception {
      state = previous;
    }
  }

  Future<void> clearCache() async {
    await ref.read(clearCacheUseCaseProvider).call();
  }

  Future<void> setAppAppearance({required AppTheme theme}) async {
    final current = state.value;
    if (current == null) {
      return;
    }

    final previous = state;
    state = AsyncData(current.copyWith(appAppearance: theme));

    try {
      await ref.read(setAppAppearanceUseCaseProvider).call(theme: theme);
    } on Exception {
      state = previous;
    }
  }
}
