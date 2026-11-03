import 'package:sharehop/core/repositories/app_config_repository.dart';

class SetSimultaneousTransfersLimitUseCase {
  new(this._appConfigRepository);

  final AppConfigRepository _appConfigRepository;

  Future<void> call({required int limit}) async =>
      await _appConfigRepository.setSimultaneousTransfersLimit(limit: limit);
}
