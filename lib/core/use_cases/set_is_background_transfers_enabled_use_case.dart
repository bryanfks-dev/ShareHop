import 'package:sharehop/core/repositories/app_config_repository.dart';

class SetIsBackgroundTransfersEnabledUseCase {
  const new(this._appConfigRepository);

  final AppConfigRepository _appConfigRepository;

  Future<void> call({required bool enabled}) async => await _appConfigRepository
      .setIsBackgroundTransfersEnabled(enabled: enabled);
}
