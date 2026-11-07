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
          AsyncValue<ConnectionViewModel?>
        > {
  AddConnectionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addConnectionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addConnectionControllerHash();

  @$internal
  @override
  AddConnectionController create() => AddConnectionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ConnectionViewModel?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ConnectionViewModel?>>(
        value,
      ),
    );
  }
}

String _$addConnectionControllerHash() =>
    r'966717fde522a81ac5c20476b9fdd6772ac4b87c';

abstract class _$AddConnectionController
    extends $Notifier<AsyncValue<ConnectionViewModel?>> {
  AsyncValue<ConnectionViewModel?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ConnectionViewModel?>,
              AsyncValue<ConnectionViewModel?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ConnectionViewModel?>,
                AsyncValue<ConnectionViewModel?>
              >,
              AsyncValue<ConnectionViewModel?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
