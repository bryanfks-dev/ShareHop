import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';

class UpdateAppAppearanceUseCase {
  const new({required this._appConfigRepository});

  final AppConfigRepository _appConfigRepository;

  Future<void> call({required AppTheme theme}) async =>
      await _appConfigRepository.setAppTheme(theme: theme);
}
