import 'package:sharehop/core/repositories/app_config_repository.dart';

class SetIsWifiOnlyTransfersEnabledUseCase {
  const new(this._appConfigRepository);

  final AppConfigRepository _appConfigRepository;

  Future<void> call({required bool enabled}) async => await _appConfigRepository
      .setIsWifiOnlyTransfersEnabled(enabled: enabled);
}
