import 'package:sharehop/core/enums/base_enum.dart';

enum OnFileConflictsResolution implements BaseEnum {
  overwrite(label: 'Overwrite files', persistentValue: 'overwrite'),
  skip(label: 'Skip files', persistentValue: 'skip'),
  rename(label: 'Rename files', persistentValue: 'rename'),
  askeverytime(label: 'Ask every time', persistentValue: 'ask_every_time');

  new({required this.label, required this.persistentValue});

  final String label;

  @override
  final String persistentValue;
}
