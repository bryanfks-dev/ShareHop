// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_connection_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddConnectionController)
final addConnectionControllerProvider = AddConnectionControllerProvider._();

final class AddConnectionControllerProvider
    extends
        $NotifierProvider<
          AddConnectionController,
          AsyncValue<ConnectionModel?>
        > {
  AddConnectionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addConnectionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addConnectionControllerHash();

  @$internal
  @override
  AddConnectionController create() => AddConnectionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ConnectionModel?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ConnectionModel?>>(value),
    );
  }
}

String _$addConnectionControllerHash() =>
    r'3f319128d41b9fafac8f980b4d0a138613ac7c0f';

abstract class _$AddConnectionController
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
