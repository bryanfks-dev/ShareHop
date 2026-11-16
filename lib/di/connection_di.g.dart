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
    r'bec08968c0b6563f17b1a3d17224ffd6ef40c0ce';

@ProviderFor(pinnedConnectionRepository)
final pinnedConnectionRepositoryProvider =
    PinnedConnectionRepositoryProvider._();

final class PinnedConnectionRepositoryProvider
    extends
        $FunctionalProvider<
          PinnedConnectionRepository,
          PinnedConnectionRepository,
          PinnedConnectionRepository
        >
    with $Provider<PinnedConnectionRepository> {
  PinnedConnectionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pinnedConnectionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pinnedConnectionRepositoryHash();

  @$internal
  @override
  $ProviderElement<PinnedConnectionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PinnedConnectionRepository create(Ref ref) {
    return pinnedConnectionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PinnedConnectionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PinnedConnectionRepository>(value),
    );
  }
}

String _$pinnedConnectionRepositoryHash() =>
    r'6418842c9f7997deb3bb13ea7bb5735bd020e059';

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
    r'bc3fce35d476144b97f683a66afc9fda18ad4d76';

@ProviderFor(webDavStorageGateway)
final webDavStorageGatewayProvider = WebDavStorageGatewayProvider._();

final class WebDavStorageGatewayProvider
    extends
        $FunctionalProvider<
          WebDavStorageGateway,
          WebDavStorageGateway,
          WebDavStorageGateway
        >
    with $Provider<WebDavStorageGateway> {
  WebDavStorageGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webDavStorageGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webDavStorageGatewayHash();

  @$internal
  @override
  $ProviderElement<WebDavStorageGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WebDavStorageGateway create(Ref ref) {
    return webDavStorageGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebDavStorageGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebDavStorageGateway>(value),
    );
  }
}

String _$webDavStorageGatewayHash() =>
    r'405bf2eb3f12b5a5499dd823e56f7fe1747987c4';

@ProviderFor(connectionService)
final connectionServiceProvider = ConnectionServiceProvider._();

final class ConnectionServiceProvider
    extends
        $FunctionalProvider<
          ConnectionService,
          ConnectionService,
          ConnectionService
        >
    with $Provider<ConnectionService> {
  ConnectionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectionServiceHash();

  @$internal
  @override
  $ProviderElement<ConnectionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConnectionService create(Ref ref) {
    return connectionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConnectionService>(value),
    );
  }
}

String _$connectionServiceHash() => r'748d34c91c14ee7ff878ec9c9266f1a4b83c88cb';

@ProviderFor(connectionFactory)
final connectionFactoryProvider = ConnectionFactoryProvider._();

final class ConnectionFactoryProvider
    extends
        $FunctionalProvider<
          ConnectionFactory,
          ConnectionFactory,
          ConnectionFactory
        >
    with $Provider<ConnectionFactory> {
  ConnectionFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectionFactoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectionFactoryHash();

  @$internal
  @override
  $ProviderElement<ConnectionFactory> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConnectionFactory create(Ref ref) {
    return connectionFactory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectionFactory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConnectionFactory>(value),
    );
  }
}

String _$connectionFactoryHash() => r'5630518d06f2507bbe1f90c1786394d24f2a3ad1';

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
    r'e27905f87558a0417b9e6730384ccae89767543b';

@ProviderFor(pinConnectionUseCase)
final pinConnectionUseCaseProvider = PinConnectionUseCaseProvider._();

final class PinConnectionUseCaseProvider
    extends
        $FunctionalProvider<
          PinConnectionUseCase,
          PinConnectionUseCase,
          PinConnectionUseCase
        >
    with $Provider<PinConnectionUseCase> {
  PinConnectionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pinConnectionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pinConnectionUseCaseHash();

  @$internal
  @override
  $ProviderElement<PinConnectionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PinConnectionUseCase create(Ref ref) {
    return pinConnectionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PinConnectionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PinConnectionUseCase>(value),
    );
  }
}

String _$pinConnectionUseCaseHash() =>
    r'25e96e30039fc5d0f0a3e25f435ec322e1aad570';

@ProviderFor(unpinConnectionUseCase)
final unpinConnectionUseCaseProvider = UnpinConnectionUseCaseProvider._();

final class UnpinConnectionUseCaseProvider
    extends
        $FunctionalProvider<
          UnpinConnectionUseCase,
          UnpinConnectionUseCase,
          UnpinConnectionUseCase
        >
    with $Provider<UnpinConnectionUseCase> {
  UnpinConnectionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unpinConnectionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unpinConnectionUseCaseHash();

  @$internal
  @override
  $ProviderElement<UnpinConnectionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UnpinConnectionUseCase create(Ref ref) {
    return unpinConnectionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UnpinConnectionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UnpinConnectionUseCase>(value),
    );
  }
}

String _$unpinConnectionUseCaseHash() =>
    r'a189988ad841de0d09c9f177e175391c39d36a2a';

@ProviderFor(getConnectionsUseCase)
final getConnectionsUseCaseProvider = GetConnectionsUseCaseProvider._();

final class GetConnectionsUseCaseProvider
    extends
        $FunctionalProvider<
          GetConnectionsUseCase,
          GetConnectionsUseCase,
          GetConnectionsUseCase
        >
    with $Provider<GetConnectionsUseCase> {
  GetConnectionsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getConnectionsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getConnectionsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetConnectionsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetConnectionsUseCase create(Ref ref) {
    return getConnectionsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetConnectionsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetConnectionsUseCase>(value),
    );
  }
}

String _$getConnectionsUseCaseHash() =>
    r'f2fd524ba792d5487913ffd44a8745cc9ed16e3d';

@ProviderFor(getPinnedConnectionIdsUseCase)
final getPinnedConnectionIdsUseCaseProvider =
    GetPinnedConnectionIdsUseCaseProvider._();

final class GetPinnedConnectionIdsUseCaseProvider
    extends
        $FunctionalProvider<
          GetPinnedConnectionIdsUseCase,
          GetPinnedConnectionIdsUseCase,
          GetPinnedConnectionIdsUseCase
        >
    with $Provider<GetPinnedConnectionIdsUseCase> {
  GetPinnedConnectionIdsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPinnedConnectionIdsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPinnedConnectionIdsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPinnedConnectionIdsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPinnedConnectionIdsUseCase create(Ref ref) {
    return getPinnedConnectionIdsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPinnedConnectionIdsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPinnedConnectionIdsUseCase>(
        value,
      ),
    );
  }
}

String _$getPinnedConnectionIdsUseCaseHash() =>
    r'97a8d78172f73f2e3f9027a627d5d40d188b8c2e';

@ProviderFor(deleteConnectionUseCase)
final deleteConnectionUseCaseProvider = DeleteConnectionUseCaseProvider._();

final class DeleteConnectionUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteConnectionUseCase,
          DeleteConnectionUseCase,
          DeleteConnectionUseCase
        >
    with $Provider<DeleteConnectionUseCase> {
  DeleteConnectionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteConnectionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteConnectionUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteConnectionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteConnectionUseCase create(Ref ref) {
    return deleteConnectionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteConnectionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteConnectionUseCase>(value),
    );
  }
}

String _$deleteConnectionUseCaseHash() =>
    r'da9f8bf927e76643a3d5ae6b70707ee38a2caf77';

@ProviderFor(updateConnectionUseCase)
final updateConnectionUseCaseProvider = UpdateConnectionUseCaseProvider._();

final class UpdateConnectionUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateConnectionUseCase,
          UpdateConnectionUseCase,
          UpdateConnectionUseCase
        >
    with $Provider<UpdateConnectionUseCase> {
  UpdateConnectionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateConnectionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateConnectionUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateConnectionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateConnectionUseCase create(Ref ref) {
    return updateConnectionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateConnectionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateConnectionUseCase>(value),
    );
  }
}

String _$updateConnectionUseCaseHash() =>
    r'b843462a9fb133cab33ad5abfb965996da9197c2';

@ProviderFor(checkConnectionStatusUseCase)
final checkConnectionStatusUseCaseProvider =
    CheckConnectionStatusUseCaseProvider._();

final class CheckConnectionStatusUseCaseProvider
    extends
        $FunctionalProvider<
          CheckConnectionStatusUseCase,
          CheckConnectionStatusUseCase,
          CheckConnectionStatusUseCase
        >
    with $Provider<CheckConnectionStatusUseCase> {
  CheckConnectionStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkConnectionStatusUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkConnectionStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<CheckConnectionStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckConnectionStatusUseCase create(Ref ref) {
    return checkConnectionStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckConnectionStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckConnectionStatusUseCase>(value),
    );
  }
}

String _$checkConnectionStatusUseCaseHash() =>
    r'8414396dc5e703df234dbffc634f958fb151ff43';

@ProviderFor(connectionCredentialMapper)
final connectionCredentialMapperProvider =
    ConnectionCredentialMapperProvider._();

final class ConnectionCredentialMapperProvider
    extends
        $FunctionalProvider<
          ConnectionCredentialMapper,
          ConnectionCredentialMapper,
          ConnectionCredentialMapper
        >
    with $Provider<ConnectionCredentialMapper> {
  ConnectionCredentialMapperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectionCredentialMapperProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectionCredentialMapperHash();

  @$internal
  @override
  $ProviderElement<ConnectionCredentialMapper> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConnectionCredentialMapper create(Ref ref) {
    return connectionCredentialMapper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectionCredentialMapper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConnectionCredentialMapper>(value),
    );
  }
}

String _$connectionCredentialMapperHash() =>
    r'377a7fbf5d8fd5bd8b638f50173f14e588312f6a';

@ProviderFor(encryptedValueMapper)
final encryptedValueMapperProvider = EncryptedValueMapperProvider._();

final class EncryptedValueMapperProvider
    extends
        $FunctionalProvider<
          EncryptedValueMapper,
          EncryptedValueMapper,
          EncryptedValueMapper
        >
    with $Provider<EncryptedValueMapper> {
  EncryptedValueMapperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'encryptedValueMapperProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$encryptedValueMapperHash();

  @$internal
  @override
  $ProviderElement<EncryptedValueMapper> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EncryptedValueMapper create(Ref ref) {
    return encryptedValueMapper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EncryptedValueMapper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EncryptedValueMapper>(value),
    );
  }
}

String _$encryptedValueMapperHash() =>
    r'872eb93a686a6b73111ca218079bd7ca1022a7ab';

@ProviderFor(connectionMapper)
final connectionMapperProvider = ConnectionMapperProvider._();

final class ConnectionMapperProvider
    extends
        $FunctionalProvider<
          ConnectionMapper,
          ConnectionMapper,
          ConnectionMapper
        >
    with $Provider<ConnectionMapper> {
  ConnectionMapperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectionMapperProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectionMapperHash();

  @$internal
  @override
  $ProviderElement<ConnectionMapper> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ConnectionMapper create(Ref ref) {
    return connectionMapper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectionMapper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConnectionMapper>(value),
    );
  }
}

String _$connectionMapperHash() => r'b5496b23695ecffa20f63522bc6e48b9ac174a10';
