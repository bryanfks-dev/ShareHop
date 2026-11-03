import 'package:sharehop/core/enums/on_file_conflicts_resolution.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';

class SetOnFileConflictsResolutionUseCase {
  new(this._appConfigRepository);

  final AppConfigRepository _appConfigRepository;

  Future<void> call({required OnFileConflictsResolution resolution}) async =>
      await _appConfigRepository.setOnFileConflictsResolution(
        resolution: resolution,
      );
}
