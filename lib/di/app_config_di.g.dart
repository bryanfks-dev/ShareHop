// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(secureRandom)
final secureRandomProvider = SecureRandomProvider._();

final class SecureRandomProvider
    extends $FunctionalProvider<SecureRandom, SecureRandom, SecureRandom>
    with $Provider<SecureRandom> {
  SecureRandomProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureRandomProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureRandomHash();

  @$internal
  @override
  $ProviderElement<SecureRandom> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SecureRandom create(Ref ref) {
    return secureRandom(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureRandom value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureRandom>(value),
    );
  }
}

String _$secureRandomHash() => r'0cb52bb76efad328678856f2395b0542994cc32d';

@ProviderFor(appConfigRepository)
final appConfigRepositoryProvider = AppConfigRepositoryProvider._();

final class AppConfigRepositoryProvider
    extends
        $FunctionalProvider<
          AppConfigRepository,
          AppConfigRepository,
          AppConfigRepository
        >
    with $Provider<AppConfigRepository> {
  AppConfigRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppConfigRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppConfigRepository create(Ref ref) {
    return appConfigRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppConfigRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppConfigRepository>(value),
    );
  }
}

String _$appConfigRepositoryHash() =>
    r'322fdbbb4ecdf43e7a221c0a95f32f8440ca8bcb';

@ProviderFor(biometricLockGateway)
final biometricLockGatewayProvider = BiometricLockGatewayProvider._();

final class BiometricLockGatewayProvider
    extends
        $FunctionalProvider<
          BiometricLockGateway,
          BiometricLockGateway,
          BiometricLockGateway
        >
    with $Provider<BiometricLockGateway> {
  BiometricLockGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricLockGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricLockGatewayHash();

  @$internal
  @override
  $ProviderElement<BiometricLockGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BiometricLockGateway create(Ref ref) {
    return biometricLockGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiometricLockGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiometricLockGateway>(value),
    );
  }
}

String _$biometricLockGatewayHash() =>
    r'ca8d1cefe6cef467ce00c1937d091fcd4f6d610c';

@ProviderFor(getAppConfigUseCase)
final getAppConfigUseCaseProvider = GetAppConfigUseCaseProvider._();

final class GetAppConfigUseCaseProvider
    extends
        $FunctionalProvider<
          GetAppConfigUseCase,
          GetAppConfigUseCase,
          GetAppConfigUseCase
        >
    with $Provider<GetAppConfigUseCase> {
  GetAppConfigUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAppConfigUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAppConfigUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAppConfigUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAppConfigUseCase create(Ref ref) {
    return getAppConfigUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAppConfigUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAppConfigUseCase>(value),
    );
  }
}

String _$getAppConfigUseCaseHash() =>
    r'3d831864aa46c9dfbe736b84c482d55240752080';

@ProviderFor(updateIsWifiOnlyTransfersEnabledUseCase)
final updateIsWifiOnlyTransfersEnabledUseCaseProvider =
    UpdateIsWifiOnlyTransfersEnabledUseCaseProvider._();

final class UpdateIsWifiOnlyTransfersEnabledUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateIsWifiOnlyTransfersEnabledUseCase,
          UpdateIsWifiOnlyTransfersEnabledUseCase,
          UpdateIsWifiOnlyTransfersEnabledUseCase
        >
    with $Provider<UpdateIsWifiOnlyTransfersEnabledUseCase> {
  UpdateIsWifiOnlyTransfersEnabledUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateIsWifiOnlyTransfersEnabledUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$updateIsWifiOnlyTransfersEnabledUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateIsWifiOnlyTransfersEnabledUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateIsWifiOnlyTransfersEnabledUseCase create(Ref ref) {
    return updateIsWifiOnlyTransfersEnabledUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateIsWifiOnlyTransfersEnabledUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<UpdateIsWifiOnlyTransfersEnabledUseCase>(value),
    );
  }
}

String _$updateIsWifiOnlyTransfersEnabledUseCaseHash() =>
    r'992d7e9a9d8e31124a4a39efc4cf298aa9ff1bfc';

@ProviderFor(updateIsBackgroundTransfersEnabledUseCase)
final updateIsBackgroundTransfersEnabledUseCaseProvider =
    UpdateIsBackgroundTransfersEnabledUseCaseProvider._();

final class UpdateIsBackgroundTransfersEnabledUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateIsBackgroundTransfersEnabledUseCase,
          UpdateIsBackgroundTransfersEnabledUseCase,
          UpdateIsBackgroundTransfersEnabledUseCase
        >
    with $Provider<UpdateIsBackgroundTransfersEnabledUseCase> {
  UpdateIsBackgroundTransfersEnabledUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateIsBackgroundTransfersEnabledUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$updateIsBackgroundTransfersEnabledUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateIsBackgroundTransfersEnabledUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateIsBackgroundTransfersEnabledUseCase create(Ref ref) {
    return updateIsBackgroundTransfersEnabledUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateIsBackgroundTransfersEnabledUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<UpdateIsBackgroundTransfersEnabledUseCase>(value),
    );
  }
}

String _$updateIsBackgroundTransfersEnabledUseCaseHash() =>
    r'655b28522e71ddb463dc14abdaa832b55b94bc75';

@ProviderFor(updateSimultaneousTransfersLimitUseCase)
final updateSimultaneousTransfersLimitUseCaseProvider =
    UpdateSimultaneousTransfersLimitUseCaseProvider._();

final class UpdateSimultaneousTransfersLimitUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateSimultaneousTransfersLimitUseCase,
          UpdateSimultaneousTransfersLimitUseCase,
          UpdateSimultaneousTransfersLimitUseCase
        >
    with $Provider<UpdateSimultaneousTransfersLimitUseCase> {
  UpdateSimultaneousTransfersLimitUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateSimultaneousTransfersLimitUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$updateSimultaneousTransfersLimitUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateSimultaneousTransfersLimitUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateSimultaneousTransfersLimitUseCase create(Ref ref) {
    return updateSimultaneousTransfersLimitUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateSimultaneousTransfersLimitUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<UpdateSimultaneousTransfersLimitUseCase>(value),
    );
  }
}

String _$updateSimultaneousTransfersLimitUseCaseHash() =>
    r'a883f62eb833bfed887a8ce9278db668f968c689';

@ProviderFor(updateOnFileConflictsResolutionUseCase)
final updateOnFileConflictsResolutionUseCaseProvider =
    UpdateOnFileConflictsResolutionUseCaseProvider._();

final class UpdateOnFileConflictsResolutionUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateOnFileConflictsResolutionUseCase,
          UpdateOnFileConflictsResolutionUseCase,
          UpdateOnFileConflictsResolutionUseCase
        >
    with $Provider<UpdateOnFileConflictsResolutionUseCase> {
  UpdateOnFileConflictsResolutionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateOnFileConflictsResolutionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$updateOnFileConflictsResolutionUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateOnFileConflictsResolutionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateOnFileConflictsResolutionUseCase create(Ref ref) {
    return updateOnFileConflictsResolutionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateOnFileConflictsResolutionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<UpdateOnFileConflictsResolutionUseCase>(value),
    );
  }
}

String _$updateOnFileConflictsResolutionUseCaseHash() =>
    r'4e409a43dbcd4eff2f28fba61628ce9c91ccc34c';

@ProviderFor(updateIsBiometricLockEnabledUseCase)
final updateIsBiometricLockEnabledUseCaseProvider =
    UpdateIsBiometricLockEnabledUseCaseProvider._();

final class UpdateIsBiometricLockEnabledUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateIsBiometricLockEnabledUseCase,
          UpdateIsBiometricLockEnabledUseCase,
          UpdateIsBiometricLockEnabledUseCase
        >
    with $Provider<UpdateIsBiometricLockEnabledUseCase> {
  UpdateIsBiometricLockEnabledUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateIsBiometricLockEnabledUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$updateIsBiometricLockEnabledUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateIsBiometricLockEnabledUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateIsBiometricLockEnabledUseCase create(Ref ref) {
    return updateIsBiometricLockEnabledUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateIsBiometricLockEnabledUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateIsBiometricLockEnabledUseCase>(
        value,
      ),
    );
  }
}

String _$updateIsBiometricLockEnabledUseCaseHash() =>
    r'22096e44348e6040604af9760941d604e01936c1';

@ProviderFor(updateDownloadDestinationPathUseCase)
final updateDownloadDestinationPathUseCaseProvider =
    UpdateDownloadDestinationPathUseCaseProvider._();

final class UpdateDownloadDestinationPathUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateDownloadDestinationPathUseCase,
          UpdateDownloadDestinationPathUseCase,
          UpdateDownloadDestinationPathUseCase
        >
    with $Provider<UpdateDownloadDestinationPathUseCase> {
  UpdateDownloadDestinationPathUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateDownloadDestinationPathUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$updateDownloadDestinationPathUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateDownloadDestinationPathUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateDownloadDestinationPathUseCase create(Ref ref) {
    return updateDownloadDestinationPathUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateDownloadDestinationPathUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<UpdateDownloadDestinationPathUseCase>(value),
    );
  }
}

String _$updateDownloadDestinationPathUseCaseHash() =>
    r'fc00ce95bd8425efd9b53d634d621666a833c64f';

@ProviderFor(clearCacheUseCase)
final clearCacheUseCaseProvider = ClearCacheUseCaseProvider._();

final class ClearCacheUseCaseProvider
    extends
        $FunctionalProvider<
          ClearCacheUseCase,
          ClearCacheUseCase,
          ClearCacheUseCase
        >
    with $Provider<ClearCacheUseCase> {
  ClearCacheUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clearCacheUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clearCacheUseCaseHash();

  @$internal
  @override
  $ProviderElement<ClearCacheUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClearCacheUseCase create(Ref ref) {
    return clearCacheUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClearCacheUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClearCacheUseCase>(value),
    );
  }
}

String _$clearCacheUseCaseHash() => r'21b312ce9050ee71dbd9b00f88b75201fa29f30e';

@ProviderFor(getCacheSizeUseCase)
final getCacheSizeUseCaseProvider = GetCacheSizeUseCaseProvider._();

final class GetCacheSizeUseCaseProvider
    extends
        $FunctionalProvider<
          GetCacheSizeUseCase,
          GetCacheSizeUseCase,
          GetCacheSizeUseCase
        >
    with $Provider<GetCacheSizeUseCase> {
  GetCacheSizeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCacheSizeUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCacheSizeUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCacheSizeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCacheSizeUseCase create(Ref ref) {
    return getCacheSizeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCacheSizeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCacheSizeUseCase>(value),
    );
  }
}

String _$getCacheSizeUseCaseHash() =>
    r'7b9fe88d178986df94093653d4fe670868607575';

@ProviderFor(updateAppAppearanceUseCase)
final updateAppAppearanceUseCaseProvider =
    UpdateAppAppearanceUseCaseProvider._();

final class UpdateAppAppearanceUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateAppAppearanceUseCase,
          UpdateAppAppearanceUseCase,
          UpdateAppAppearanceUseCase
        >
    with $Provider<UpdateAppAppearanceUseCase> {
  UpdateAppAppearanceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateAppAppearanceUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateAppAppearanceUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateAppAppearanceUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateAppAppearanceUseCase create(Ref ref) {
    return updateAppAppearanceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateAppAppearanceUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateAppAppearanceUseCase>(value),
    );
  }
}

String _$updateAppAppearanceUseCaseHash() =>
    r'7eeb7e75f981be02afeadd30ebf2abdfa7c679c6';
