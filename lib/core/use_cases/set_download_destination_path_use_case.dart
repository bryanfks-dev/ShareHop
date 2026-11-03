import 'package:sharehop/core/repositories/app_config_repository.dart';

class SetDownloadDestinationPathUseCase {
  const new(this._appConfigRepository);

  final AppConfigRepository _appConfigRepository;

  Future<void> call({required String path}) async =>
      await _appConfigRepository.setDownloadDestinationPath(path: path);
}
