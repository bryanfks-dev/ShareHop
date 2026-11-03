import 'package:sharehop/core/enums/base_enum.dart';

enum AppTheme implements BaseEnum {
  light(label: 'Light', persistentValue: 'light'),
  dark(label: 'Dark', persistentValue: 'dark'),
  system(label: 'System', persistentValue: 'system');

  new({required this.label, required this.persistentValue});

  final String label;

  @override
  final String persistentValue;
}
