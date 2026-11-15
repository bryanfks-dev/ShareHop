// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_transfer_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FileTransferHistoryController)
final fileTransferHistoryControllerProvider =
    FileTransferHistoryControllerProvider._();

final class FileTransferHistoryControllerProvider
    extends
        $NotifierProvider<
          FileTransferHistoryController,
          FileTransferHistoryState
        > {
  FileTransferHistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileTransferHistoryControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileTransferHistoryControllerHash();

  @$internal
  @override
  FileTransferHistoryController create() => FileTransferHistoryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileTransferHistoryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileTransferHistoryState>(value),
    );
  }
}

String _$fileTransferHistoryControllerHash() =>
    r'7bceac787b696e0dcdb8f8eee3d785d5ccf6e43d';

abstract class _$FileTransferHistoryController
    extends $Notifier<FileTransferHistoryState> {
  FileTransferHistoryState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<FileTransferHistoryState, FileTransferHistoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FileTransferHistoryState, FileTransferHistoryState>,
              FileTransferHistoryState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
