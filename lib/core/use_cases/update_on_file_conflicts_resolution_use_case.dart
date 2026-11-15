import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';

class UpdateOnFileConflictsResolutionUseCase {
  const new({required this._appConfigRepository});

  final AppConfigRepository _appConfigRepository;

  Future<void> call({required FileConflictsResolution resolution}) async =>
      await _appConfigRepository.setFileConflictResolution(
        resolution: resolution,
      );
}
