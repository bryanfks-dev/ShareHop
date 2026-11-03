import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/repositories/app_info_repository.dart';
import 'package:sharehop/core/use_cases/get_app_info_use_case.dart';
import 'package:sharehop/infrastructures/repositories/app_info_repository_impl.dart';
part 'app_info_di.g.dart';

@Riverpod(keepAlive: true)
AppInfoRepository appInfoRepository(Ref ref) => AppInfoRepositoryImpl();

@Riverpod(keepAlive: true)
GetAppInfoUseCase getAppVersionUseCase(Ref ref) =>
    GetAppInfoUseCase(ref.watch(appInfoRepositoryProvider));
