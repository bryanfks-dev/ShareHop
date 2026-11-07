import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/presentation/controllers/app_config_controller.dart';

class FakeAppConfigRepository implements AppConfigRepository {
  AppConfigModel model = AppConfigModel(
    isWifiOnlyTransfersEnabled: true,
    isBackgroundTransfersEnabled: true,
    simultaneousTransfersLimit: 3,
    onFileConflictsResolution: FileConflictsResolution.askeverytime,
    isBiometricLockEnabled: false,
    downloadDestinationPath: '/default',
    appAppearance: AppTheme.system,
  );

  bool shouldThrow = false;

  @override
  Future<AppConfigModel> getConfig() async {
    if (shouldThrow) {
      throw Exception('Failed to get config');
    }
    return model;
  }

  @override
  Future<String> getEncryptionKey() async => 'test-key';

  @override
  Future<void> setAppTheme({required AppTheme theme}) async {
    if (shouldThrow) {
      throw Exception('Failed to set theme');
    }
    model = model.copyWith(appAppearance: theme);
  }

  @override
  Future<void> setBackgroundTransfersEnabled({required bool enabled}) async {
    if (shouldThrow) {
      throw Exception('Failed to set background transfers');
    }
    model = model.copyWith(isBackgroundTransfersEnabled: enabled);
  }

  @override
  Future<void> setBiometricLockEnabled({required bool enabled}) async {
    if (shouldThrow) {
      throw Exception('Failed to set biometric lock');
    }
    model = model.copyWith(isBiometricLockEnabled: enabled);
  }

  @override
  Future<void> setDownloadPath({required String path}) async {
    if (shouldThrow) {
      throw Exception('Failed to set download path');
    }
    model = model.copyWith(downloadDestinationPath: path);
  }

  @override
  Future<void> setFileConflictResolution({
    required FileConflictsResolution resolution,
  }) async {
    if (shouldThrow) {
      throw Exception('Failed to set resolution');
    }
    model = model.copyWith(onFileConflictsResolution: resolution);
  }

  @override
  Future<void> setMaxSimultaneousTransfers({required int limit}) async {
    if (shouldThrow) {
      throw Exception('Failed to set limit');
    }
    model = model.copyWith(simultaneousTransfersLimit: limit);
  }

  @override
  Future<void> setWifiOnlyTransfersEnabled({required bool enabled}) async {
    if (shouldThrow) {
      throw Exception('Failed to set wifi only');
    }
    model = model.copyWith(isWifiOnlyTransfersEnabled: enabled);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeAppConfigRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeAppConfigRepository();
    container = ProviderContainer(
      overrides: [appConfigRepositoryProvider.overrideWithValue(repository)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AppConfigController', () {
    test('loads initial config on build', () async {
      final config = await container.read(appConfigControllerProvider.future);
      expect(config.isWifiOnlyTransfersEnabled, isTrue);
      expect(config.simultaneousTransfersLimit, 3);
      expect(config.downloadDestinationPath, '/default');
    });

    test(
      'updates isWifiOnlyTransfersEnabled optimistically and persists',
      () async {
        await container.read(appConfigControllerProvider.future);
        final controller = container.read(appConfigControllerProvider.notifier);

        await controller.setIsWifiOnlyTransfersEnabled(enabled: false);

        expect(
          container
              .read(appConfigControllerProvider)
              .value
              ?.isWifiOnlyTransfersEnabled,
          isFalse,
        );
        expect(repository.model.isWifiOnlyTransfersEnabled, isFalse);
      },
    );

    test(
      'rolls back isWifiOnlyTransfersEnabled when repository fails',
      () async {
        await container.read(appConfigControllerProvider.future);
        final controller = container.read(appConfigControllerProvider.notifier);

        repository.shouldThrow = true;
        await controller.setIsWifiOnlyTransfersEnabled(enabled: false);

        expect(
          container
              .read(appConfigControllerProvider)
              .value
              ?.isWifiOnlyTransfersEnabled,
          isTrue,
        );
      },
    );

    test(
      'updates isBackgroundTransfersEnabled optimistically and persists',
      () async {
        await container.read(appConfigControllerProvider.future);
        final controller = container.read(appConfigControllerProvider.notifier);

        await controller.setIsBackgroundTransfersEnabled(enabled: false);

        expect(
          container
              .read(appConfigControllerProvider)
              .value
              ?.isBackgroundTransfersEnabled,
          isFalse,
        );
        expect(repository.model.isBackgroundTransfersEnabled, isFalse);
      },
    );

    test(
      'updates simultaneousTransfersLimit optimistically and persists',
      () async {
        await container.read(appConfigControllerProvider.future);
        final controller = container.read(appConfigControllerProvider.notifier);

        await controller.setSimultaneousTransfersLimit(limit: 5);

        expect(
          container
              .read(appConfigControllerProvider)
              .value
              ?.simultaneousTransfersLimit,
          5,
        );
        expect(repository.model.simultaneousTransfersLimit, 5);
      },
    );

    test(
      'updates onFileConflictsResolution optimistically and persists',
      () async {
        await container.read(appConfigControllerProvider.future);
        final controller = container.read(appConfigControllerProvider.notifier);

        await controller.setOnFileConflictsResolution(
          resolution: FileConflictsResolution.overwrite,
        );

        expect(
          container
              .read(appConfigControllerProvider)
              .value
              ?.onFileConflictsResolution,
          FileConflictsResolution.overwrite,
        );
        expect(
          repository.model.onFileConflictsResolution,
          FileConflictsResolution.overwrite,
        );
      },
    );

    test(
      'updates isBiometricLockEnabled optimistically and persists',
      () async {
        await container.read(appConfigControllerProvider.future);
        final controller = container.read(appConfigControllerProvider.notifier);

        await controller.setIsBiometricLockEnabled(enabled: true);

        expect(
          container
              .read(appConfigControllerProvider)
              .value
              ?.isBiometricLockEnabled,
          isTrue,
        );
        expect(repository.model.isBiometricLockEnabled, isTrue);
      },
    );

    test(
      'updates downloadDestinationPath optimistically and persists',
      () async {
        await container.read(appConfigControllerProvider.future);
        final controller = container.read(appConfigControllerProvider.notifier);

        await controller.setDownloadDestinationPath(path: '/new/path');

        expect(
          container
              .read(appConfigControllerProvider)
              .value
              ?.downloadDestinationPath,
          '/new/path',
        );
        expect(repository.model.downloadDestinationPath, '/new/path');
      },
    );

    test('updates appAppearance optimistically and persists', () async {
      await container.read(appConfigControllerProvider.future);
      final controller = container.read(appConfigControllerProvider.notifier);

      await controller.setAppAppearance(theme: AppTheme.dark);

      expect(
        container.read(appConfigControllerProvider).value?.appAppearance,
        AppTheme.dark,
      );
      expect(repository.model.appAppearance, AppTheme.dark);
    });

    test('clearCache executes without error', () async {
      await container.read(appConfigControllerProvider.future);
      final controller = container.read(appConfigControllerProvider.notifier);

      await expectLater(controller.clearCache(), completes);
    });
  });
}
