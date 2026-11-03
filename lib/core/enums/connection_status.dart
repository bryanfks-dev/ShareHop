import 'package:sharehop/core/enums/base_enum.dart';

enum ConnectionStatus implements BaseEnum {
  online(label: 'Online', persistentValue: 'online'),
  offline(label: 'Offline', persistentValue: 'offline');

  new({required this.label, required this.persistentValue});

  final String label;

  @override
  final String persistentValue;
}
