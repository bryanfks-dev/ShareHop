// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(connectionRepository)
final connectionRepositoryProvider = ConnectionRepositoryProvider._();

final class ConnectionRepositoryProvider
    extends
        $FunctionalProvider<
          ConnectionRepository,
          ConnectionRepository,
          ConnectionRepository
        >
    with $Provider<ConnectionRepository> {
  ConnectionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectionRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConnectionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConnectionRepository create(Ref ref) {
    return connectionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConnectionRepository>(value),
    );
  }
}

String _$connectionRepositoryHash() =>
    r'7cd5ed812fa6a4ef10dbac4bd3fa8ad4b85d19af';

@ProviderFor(webDavClientPool)
final webDavClientPoolProvider = WebDavClientPoolProvider._();

final class WebDavClientPoolProvider
    extends
        $FunctionalProvider<
          WebDavClientPool,
          WebDavClientPool,
          WebDavClientPool
        >
    with $Provider<WebDavClientPool> {
  WebDavClientPoolProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webDavClientPoolProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webDavClientPoolHash();

  @$internal
  @override
  $ProviderElement<WebDavClientPool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebDavClientPool create(Ref ref) {
    return webDavClientPool(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebDavClientPool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebDavClientPool>(value),
    );
  }
}

String _$webDavClientPoolHash() => r'7a86d1aee9ec8cc819598b30a520b2b50c65a739';

@ProviderFor(webDavClientManager)
final webDavClientManagerProvider = WebDavClientManagerProvider._();

final class WebDavClientManagerProvider
    extends
        $FunctionalProvider<
          WebDavClientManager,
          WebDavClientManager,
          WebDavClientManager
        >
    with $Provider<WebDavClientManager> {
  WebDavClientManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webDavClientManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webDavClientManagerHash();

  @$internal
  @override
  $ProviderElement<WebDavClientManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WebDavClientManager create(Ref ref) {
    return webDavClientManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebDavClientManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebDavClientManager>(value),
    );
  }
}

String _$webDavClientManagerHash() =>
    r'ceb6e5463232be5fbe828a7cfa964190bd6c11b5';

@ProviderFor(webDavStorageService)
final webDavStorageServiceProvider = WebDavStorageServiceProvider._();

final class WebDavStorageServiceProvider
    extends
        $FunctionalProvider<
          WebDavStorageService,
          WebDavStorageService,
          WebDavStorageService
        >
    with $Provider<WebDavStorageService> {
  WebDavStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webDavStorageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webDavStorageServiceHash();

  @$internal
  @override
  $ProviderElement<WebDavStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WebDavStorageService create(Ref ref) {
    return webDavStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebDavStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebDavStorageService>(value),
    );
  }
}

String _$webDavStorageServiceHash() =>
    r'89a1a239b12b3356bb0635d4a26b850873fa6747';

@ProviderFor(smbStorageService)
final smbStorageServiceProvider = SmbStorageServiceProvider._();

final class SmbStorageServiceProvider
    extends
        $FunctionalProvider<
          SmbStorageService,
          SmbStorageService,
          SmbStorageService
        >
    with $Provider<SmbStorageService> {
  SmbStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smbStorageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smbStorageServiceHash();

  @$internal
  @override
  $ProviderElement<SmbStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SmbStorageService create(Ref ref) {
    return smbStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SmbStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SmbStorageService>(value),
    );
  }
}

String _$smbStorageServiceHash() => r'f2446543856558903b65aee592f5c574e48577e3';

@ProviderFor(createConnectionUseCase)
final createConnectionUseCaseProvider = CreateConnectionUseCaseProvider._();

final class CreateConnectionUseCaseProvider
    extends
        $FunctionalProvider<
          CreateConnectionUseCase,
          CreateConnectionUseCase,
          CreateConnectionUseCase
        >
    with $Provider<CreateConnectionUseCase> {
  CreateConnectionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createConnectionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createConnectionUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateConnectionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateConnectionUseCase create(Ref ref) {
    return createConnectionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateConnectionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateConnectionUseCase>(value),
    );
  }
}

String _$createConnectionUseCaseHash() =>
    r'fab3abc7f94fe3bd58d9bfd533e0faa6ca755d18';

@ProviderFor(testConnectionUseCase)
final testConnectionUseCaseProvider = TestConnectionUseCaseProvider._();

final class TestConnectionUseCaseProvider
    extends
        $FunctionalProvider<
          TestConnectionUseCase,
          TestConnectionUseCase,
          TestConnectionUseCase
        >
    with $Provider<TestConnectionUseCase> {
  TestConnectionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testConnectionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testConnectionUseCaseHash();

  @$internal
  @override
  $ProviderElement<TestConnectionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TestConnectionUseCase create(Ref ref) {
    return testConnectionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TestConnectionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TestConnectionUseCase>(value),
    );
  }
}

String _$testConnectionUseCaseHash() =>
    r'06125f69da59d6165efb2dc01df6ec443cfb1922';

@ProviderFor(getSmbStorageStatusUseCase)
final getSmbStorageStatusUseCaseProvider =
    GetSmbStorageStatusUseCaseProvider._();

final class GetSmbStorageStatusUseCaseProvider
    extends
        $FunctionalProvider<
          GetSmbStorageStatusUseCase,
          GetSmbStorageStatusUseCase,
          GetSmbStorageStatusUseCase
        >
    with $Provider<GetSmbStorageStatusUseCase> {
  GetSmbStorageStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSmbStorageStatusUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSmbStorageStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetSmbStorageStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetSmbStorageStatusUseCase create(Ref ref) {
    return getSmbStorageStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSmbStorageStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSmbStorageStatusUseCase>(value),
    );
  }
}

String _$getSmbStorageStatusUseCaseHash() =>
    r'f87d618873dcc0c08033a32abfb2a2110ede599f';
