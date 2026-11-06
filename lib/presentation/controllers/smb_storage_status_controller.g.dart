// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smb_storage_status_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SmbStorageStatusController)
final smbStorageStatusControllerProvider = SmbStorageStatusControllerFamily._();

final class SmbStorageStatusControllerProvider
    extends
        $AsyncNotifierProvider<SmbStorageStatusController, StorageStatusDto> {
  SmbStorageStatusControllerProvider._({
    required SmbStorageStatusControllerFamily super.from,
    required ConnectionModel super.argument,
  }) : super(
         retry: null,
         name: r'smbStorageStatusControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$smbStorageStatusControllerHash();

  @override
  String toString() {
    return r'smbStorageStatusControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SmbStorageStatusController create() => SmbStorageStatusController();

  @override
  bool operator ==(Object other) {
    return other is SmbStorageStatusControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$smbStorageStatusControllerHash() =>
    r'8ccef645514b9f258ae8bd37b6fe0eb05f1712da';

final class SmbStorageStatusControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SmbStorageStatusController,
          AsyncValue<StorageStatusDto>,
          StorageStatusDto,
          FutureOr<StorageStatusDto>,
          ConnectionModel
        > {
  SmbStorageStatusControllerFamily._()
    : super(
        retry: null,
        name: r'smbStorageStatusControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SmbStorageStatusControllerProvider call(ConnectionModel connection) =>
      SmbStorageStatusControllerProvider._(argument: connection, from: this);

  @override
  String toString() => r'smbStorageStatusControllerProvider';
}

abstract class _$SmbStorageStatusController
    extends $AsyncNotifier<StorageStatusDto> {
  late final _$args = ref.$arg as ConnectionModel;
  ConnectionModel get connection => _$args;

  FutureOr<StorageStatusDto> build(ConnectionModel connection);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<StorageStatusDto>, StorageStatusDto>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StorageStatusDto>, StorageStatusDto>,
              AsyncValue<StorageStatusDto>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
