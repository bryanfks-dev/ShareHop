import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/gateways/biometric_lock_gateway.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/security/secure_random.dart';
import 'package:sharehop/core/use_cases/clear_cache_use_case.dart';
import 'package:sharehop/core/use_cases/get_app_config_use_case.dart';
import 'package:sharehop/core/use_cases/get_cache_size_use_case.dart';
import 'package:sharehop/core/use_cases/update_app_appearance_use_case.dart';
import 'package:sharehop/core/use_cases/update_download_destination_path_use_case.dart';
import 'package:sharehop/core/use_cases/update_is_background_transfers_enabled_use_case.dart';
import 'package:sharehop/core/use_cases/update_is_biometric_lock_enabled_use_case.dart';
import 'package:sharehop/core/use_cases/update_is_wifi_only_transfers_enabled_use_case.dart';
import 'package:sharehop/core/use_cases/update_on_file_conflicts_resolution_use_case.dart';
import 'package:sharehop/core/use_cases/update_simultaneous_transfers_limit_use_case.dart';
import 'package:sharehop/infrastructures/gateways/biometric_gateway_impl.dart';
import 'package:sharehop/infrastructures/repositories/app_config_repository_impl.dart';
import 'package:sharehop/infrastructures/security/secure_random_impl.dart';

part 'app_config_di.g.dart';

@Riverpod(keepAlive: true)
SecureRandom secureRandom(Ref ref) => const SecureRandomImpl();

@Riverpod(keepAlive: true)
AppConfigRepository appConfigRepository(Ref ref) =>
    AppConfigRepositoryImpl(secureRandom: ref.watch(secureRandomProvider));

@Riverpod(keepAlive: true)
BiometricLockGateway biometricLockGateway(Ref ref) =>
    BiometricLockGatewayImpl();

@Riverpod(keepAlive: true)
GetAppConfigUseCase getAppConfigUseCase(Ref ref) => GetAppConfigUseCase(
  appConfigRepository: ref.watch(appConfigRepositoryProvider),
);

@Riverpod(keepAlive: true)
UpdateIsWifiOnlyTransfersEnabledUseCase updateIsWifiOnlyTransfersEnabledUseCase(
  Ref ref,
) => UpdateIsWifiOnlyTransfersEnabledUseCase(
  appConfigRepository: ref.watch(appConfigRepositoryProvider),
);

@Riverpod(keepAlive: true)
UpdateIsBackgroundTransfersEnabledUseCase
updateIsBackgroundTransfersEnabledUseCase(Ref ref) =>
    UpdateIsBackgroundTransfersEnabledUseCase(
      appConfigRepository: ref.watch(appConfigRepositoryProvider),
    );

@Riverpod(keepAlive: true)
UpdateSimultaneousTransfersLimitUseCase updateSimultaneousTransfersLimitUseCase(
  Ref ref,
) => UpdateSimultaneousTransfersLimitUseCase(
  appConfigRepository: ref.watch(appConfigRepositoryProvider),
);

@Riverpod(keepAlive: true)
UpdateOnFileConflictsResolutionUseCase updateOnFileConflictsResolutionUseCase(
  Ref ref,
) => UpdateOnFileConflictsResolutionUseCase(
  appConfigRepository: ref.watch(appConfigRepositoryProvider),
);

@Riverpod(keepAlive: true)
UpdateIsBiometricLockEnabledUseCase updateIsBiometricLockEnabledUseCase(
  Ref ref,
) => UpdateIsBiometricLockEnabledUseCase(
  appConfigRepository: ref.watch(appConfigRepositoryProvider),
);

@Riverpod(keepAlive: true)
UpdateDownloadDestinationPathUseCase updateDownloadDestinationPathUseCase(
  Ref ref,
) => UpdateDownloadDestinationPathUseCase(
  appConfigRepository: ref.watch(appConfigRepositoryProvider),
);

@Riverpod(keepAlive: true)
ClearCacheUseCase clearCacheUseCase(Ref ref) => const ClearCacheUseCase();

@Riverpod(keepAlive: true)
GetCacheSizeUseCase getCacheSizeUseCase(Ref ref) => const GetCacheSizeUseCase();

@Riverpod(keepAlive: true)
UpdateAppAppearanceUseCase updateAppAppearanceUseCase(Ref ref) =>
    UpdateAppAppearanceUseCase(
      appConfigRepository: ref.watch(appConfigRepositoryProvider),
    );
