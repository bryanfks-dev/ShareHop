// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connections_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConnectionsController)
final connectionsControllerProvider = ConnectionsControllerProvider._();

final class ConnectionsControllerProvider
    extends
        $NotifierProvider<ConnectionsController, List<ConnectionViewModel>> {
  ConnectionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectionsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectionsControllerHash();

  @$internal
  @override
  ConnectionsController create() => ConnectionsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ConnectionViewModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ConnectionViewModel>>(value),
    );
  }
}

String _$connectionsControllerHash() =>
    r'609aae309695d777b89b41be3919f73f92b06656';

abstract class _$ConnectionsController
    extends $Notifier<List<ConnectionViewModel>> {
  List<ConnectionViewModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<ConnectionViewModel>, List<ConnectionViewModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ConnectionViewModel>, List<ConnectionViewModel>>,
              List<ConnectionViewModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
