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
    r'd3928d39c0a0adac2224fd690e47aef0587147c6';

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
    r'35b6d68b8bfb12d96e3df384cb7bf14ec5d24aef';

@ProviderFor(testWebDavConnectionUseCase)
final testWebDavConnectionUseCaseProvider =
    TestWebDavConnectionUseCaseProvider._();

final class TestWebDavConnectionUseCaseProvider
    extends
        $FunctionalProvider<
          TestWebDavConnectionUseCase,
          TestWebDavConnectionUseCase,
          TestWebDavConnectionUseCase
        >
    with $Provider<TestWebDavConnectionUseCase> {
  TestWebDavConnectionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testWebDavConnectionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testWebDavConnectionUseCaseHash();

  @$internal
  @override
  $ProviderElement<TestWebDavConnectionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TestWebDavConnectionUseCase create(Ref ref) {
    return testWebDavConnectionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TestWebDavConnectionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TestWebDavConnectionUseCase>(value),
    );
  }
}

String _$testWebDavConnectionUseCaseHash() =>
    r'ab0444474766ef4a2bc91105de456caf1b556748';
