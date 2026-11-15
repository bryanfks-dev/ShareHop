import 'package:sharehop/core/models/app_info_model.dart';
import 'package:sharehop/core/repositories/app_info_repository.dart';

class GetAppInfoUseCase {
  const new({required this.appInfoRepository});

  final AppInfoRepository appInfoRepository;

  Future<AppInfoModel> call() async => await appInfoRepository.getInfo();
}
