// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_pinned_connections_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ManagePinnedConnectionsController)
final managePinnedConnectionsControllerProvider =
    ManagePinnedConnectionsControllerProvider._();

final class ManagePinnedConnectionsControllerProvider
    extends
        $NotifierProvider<
          ManagePinnedConnectionsController,
          ManagePinnedConnectionsState
        > {
  ManagePinnedConnectionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'managePinnedConnectionsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$managePinnedConnectionsControllerHash();

  @$internal
  @override
  ManagePinnedConnectionsController create() =>
      ManagePinnedConnectionsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ManagePinnedConnectionsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ManagePinnedConnectionsState>(value),
    );
  }
}

String _$managePinnedConnectionsControllerHash() =>
    r'3777015f258a14285c5dbe7d499bb383102976f3';

abstract class _$ManagePinnedConnectionsController
    extends $Notifier<ManagePinnedConnectionsState> {
  ManagePinnedConnectionsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<ManagePinnedConnectionsState, ManagePinnedConnectionsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ManagePinnedConnectionsState,
                ManagePinnedConnectionsState
              >,
              ManagePinnedConnectionsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
