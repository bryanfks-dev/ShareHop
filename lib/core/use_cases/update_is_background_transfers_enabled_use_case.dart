import 'package:sharehop/core/repositories/app_config_repository.dart';

class UpdateIsBackgroundTransfersEnabledUseCase {
  const new({required this._appConfigRepository});

  final AppConfigRepository _appConfigRepository;

  Future<void> call({required bool enabled}) async => await _appConfigRepository
      .setBackgroundTransfersEnabled(enabled: enabled);
}
