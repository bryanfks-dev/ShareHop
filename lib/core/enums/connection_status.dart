import 'package:sharehop/core/enums/base_enum.dart';

enum ConnectionStatus implements BaseEnum {
  online(persistentValue: 'online'),
  ready(persistentValue: 'ready'),
  idle(persistentValue: 'idle'),
  offline(persistentValue: 'offline');

  new({required this.persistentValue});

  @override
  final String persistentValue;
}
