import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';

class GetAppConfigUseCase {
  const new(this._appConfigRepository);

  final AppConfigRepository _appConfigRepository;

  Future<AppConfigModel> call() async => await _appConfigRepository.getConfig();
}
