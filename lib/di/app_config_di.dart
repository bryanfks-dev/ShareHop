import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/gateways/biometric_lock_gateway.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/use_cases/clear_cache_use_case.dart';
import 'package:sharehop/core/use_cases/get_app_config_use_case.dart';
import 'package:sharehop/core/use_cases/get_cache_size_use_case.dart';
import 'package:sharehop/core/use_cases/set_app_appearance_use_case.dart';
import 'package:sharehop/core/use_cases/set_download_destination_path_use_case.dart';
import 'package:sharehop/core/use_cases/set_is_background_transfers_enabled_use_case.dart';
import 'package:sharehop/core/use_cases/set_is_biometric_lock_enabled_use_case.dart';
import 'package:sharehop/core/use_cases/set_is_wifi_only_transfers_enabled_use_case.dart';
import 'package:sharehop/core/use_cases/set_on_file_conflicts_resolution_use_case.dart';
import 'package:sharehop/core/use_cases/set_simultaneous_transfers_limit_use_case.dart';
import 'package:sharehop/infrastructures/gateways/biometric_gateway_impl.dart';
import 'package:sharehop/infrastructures/repositories/app_config_repository_impl.dart';

part 'app_config_di.g.dart';

@Riverpod(keepAlive: true)
AppConfigRepository appConfigRepository(Ref ref) => AppConfigRepositoryImpl();

@Riverpod(keepAlive: true)
BiometricLockGateway biometricLockGateway(Ref ref) =>
    BiometricLockGatewayImpl();

@Riverpod(keepAlive: true)
GetAppConfigUseCase getAppConfigUseCase(Ref ref) =>
    GetAppConfigUseCase(ref.watch(appConfigRepositoryProvider));

@Riverpod(keepAlive: true)
SetIsWifiOnlyTransfersEnabledUseCase setIsWifiOnlyTransfersEnabledUseCase(
  Ref ref,
) => SetIsWifiOnlyTransfersEnabledUseCase(
  ref.watch(appConfigRepositoryProvider),
);

@Riverpod(keepAlive: true)
SetIsBackgroundTransfersEnabledUseCase setIsBackgroundTransfersEnabledUseCase(
  Ref ref,
) => SetIsBackgroundTransfersEnabledUseCase(
  ref.watch(appConfigRepositoryProvider),
);

@Riverpod(keepAlive: true)
SetSimultaneousTransfersLimitUseCase setSimultaneousTransfersLimitUseCase(
  Ref ref,
) => SetSimultaneousTransfersLimitUseCase(
  ref.watch(appConfigRepositoryProvider),
);

@Riverpod(keepAlive: true)
SetOnFileConflictsResolutionUseCase setOnFileConflictsResolutionUseCase(
  Ref ref,
) =>
    SetOnFileConflictsResolutionUseCase(ref.watch(appConfigRepositoryProvider));

@Riverpod(keepAlive: true)
SetIsBiometricLockEnabledUseCase setIsBiometricLockEnabledUseCase(Ref ref) =>
    SetIsBiometricLockEnabledUseCase(ref.watch(appConfigRepositoryProvider));

@Riverpod(keepAlive: true)
SetDownloadDestinationPathUseCase setDownloadDestinationPathUseCase(Ref ref) =>
    SetDownloadDestinationPathUseCase(ref.watch(appConfigRepositoryProvider));

@Riverpod(keepAlive: true)
ClearCacheUseCase clearCacheUseCase(Ref ref) => const ClearCacheUseCase();

@Riverpod(keepAlive: true)
GetCacheSizeUseCase getCacheSizeUseCase(Ref ref) => const GetCacheSizeUseCase();

@Riverpod(keepAlive: true)
SetAppAppearanceUseCase setAppAppearanceUseCase(Ref ref) =>
    SetAppAppearanceUseCase(ref.watch(appConfigRepositoryProvider));
