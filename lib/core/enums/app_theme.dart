import 'package:sharehop/core/enums/base_enum.dart';

enum AppTheme implements BaseEnum {
  light(persistentValue: 'light'),
  dark(persistentValue: 'dark'),
  system(persistentValue: 'system');

  new({required this.persistentValue});

  @override
  final String persistentValue;
}
