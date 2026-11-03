// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppInfoController)
final appInfoControllerProvider = AppInfoControllerProvider._();

final class AppInfoControllerProvider
    extends $AsyncNotifierProvider<AppInfoController, AppInfoModel> {
  AppInfoControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appInfoControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInfoControllerHash();

  @$internal
  @override
  AppInfoController create() => AppInfoController();
}

String _$appInfoControllerHash() => r'11033db5855449b0f0617958b75b941d385e6fd2';

abstract class _$AppInfoController extends $AsyncNotifier<AppInfoModel> {
  FutureOr<AppInfoModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppInfoModel>, AppInfoModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppInfoModel>, AppInfoModel>,
              AsyncValue<AppInfoModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
