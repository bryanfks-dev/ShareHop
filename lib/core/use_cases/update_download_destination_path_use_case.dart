import 'package:sharehop/core/repositories/app_config_repository.dart';

class UpdateDownloadDestinationPathUseCase {
  const new({required this._appConfigRepository});

  final AppConfigRepository _appConfigRepository;

  Future<void> call({required String path}) async =>
      await _appConfigRepository.setDownloadPath(path: path);
}
