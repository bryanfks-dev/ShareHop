import 'package:sharehop/core/enums/base_enum.dart';

enum FileConflictsResolution implements BaseEnum {
  overwrite(persistentValue: 'overwrite'),
  skip(persistentValue: 'skip'),
  rename(persistentValue: 'rename'),
  askeverytime(persistentValue: 'ask_every_time');

  new({required this.persistentValue});

  @override
  final String persistentValue;
}
