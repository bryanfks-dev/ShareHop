// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppConfigController)
final appConfigControllerProvider = AppConfigControllerProvider._();

final class AppConfigControllerProvider
    extends $AsyncNotifierProvider<AppConfigController, AppConfigModel> {
  AppConfigControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigControllerHash();

  @$internal
  @override
  AppConfigController create() => AppConfigController();
}

String _$appConfigControllerHash() =>
    r'927da1e352d2e0459b5f4324c97e9563a05f3651';

abstract class _$AppConfigController extends $AsyncNotifier<AppConfigModel> {
  FutureOr<AppConfigModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppConfigModel>, AppConfigModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppConfigModel>, AppConfigModel>,
              AsyncValue<AppConfigModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
