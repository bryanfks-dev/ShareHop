import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/models/app_info_model.dart';
import 'package:sharehop/di/app_info_di.dart';

part 'app_info_controller.g.dart';

@Riverpod(keepAlive: true)
class AppInfoController extends _$AppInfoController {
  @override
  Future<AppInfoModel> build() async =>
      await ref.watch(getAppVersionUseCaseProvider)();
}
