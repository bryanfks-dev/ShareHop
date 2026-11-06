// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConnectionController)
final connectionControllerProvider = ConnectionControllerProvider._();

final class ConnectionControllerProvider
    extends
        $NotifierProvider<ConnectionController, AsyncValue<ConnectionModel?>> {
  ConnectionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectionControllerHash();

  @$internal
  @override
  ConnectionController create() => ConnectionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ConnectionModel?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ConnectionModel?>>(value),
    );
  }
}

String _$connectionControllerHash() =>
    r'a779806a1e0bfc2e19b29585fa9c91d20342d6b1';

abstract class _$ConnectionController
    extends $Notifier<AsyncValue<ConnectionModel?>> {
  AsyncValue<ConnectionModel?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ConnectionModel?>, AsyncValue<ConnectionModel?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ConnectionModel?>,
                AsyncValue<ConnectionModel?>
              >,
              AsyncValue<ConnectionModel?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
