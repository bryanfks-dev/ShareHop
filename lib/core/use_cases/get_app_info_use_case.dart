import 'package:sharehop/core/models/app_info_model.dart';
import 'package:sharehop/core/repositories/app_info_repository.dart';

class GetAppInfoUseCase {
  const new(this._appInfoRepository);

  final AppInfoRepository _appInfoRepository;

  Future<AppInfoModel> call() async => await _appInfoRepository.getInfo();
}
