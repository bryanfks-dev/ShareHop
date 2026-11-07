// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appInfoRepository)
final appInfoRepositoryProvider = AppInfoRepositoryProvider._();

final class AppInfoRepositoryProvider
    extends
        $FunctionalProvider<
          AppInfoRepository,
          AppInfoRepository,
          AppInfoRepository
        >
    with $Provider<AppInfoRepository> {
  AppInfoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appInfoRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInfoRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppInfoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppInfoRepository create(Ref ref) {
    return appInfoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppInfoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppInfoRepository>(value),
    );
  }
}

String _$appInfoRepositoryHash() => r'5873b3d544f0b2bca5c723e6fdb4c45eeeb825f0';

@ProviderFor(getAppVersionUseCase)
final getAppVersionUseCaseProvider = GetAppVersionUseCaseProvider._();

final class GetAppVersionUseCaseProvider
    extends
        $FunctionalProvider<
          GetAppInfoUseCase,
          GetAppInfoUseCase,
          GetAppInfoUseCase
        >
    with $Provider<GetAppInfoUseCase> {
  GetAppVersionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAppVersionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAppVersionUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAppInfoUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAppInfoUseCase create(Ref ref) {
    return getAppVersionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAppInfoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAppInfoUseCase>(value),
    );
  }
}

String _$getAppVersionUseCaseHash() =>
    r'd885b090d88cb1e7330ef455354aed0e74f1c145';
