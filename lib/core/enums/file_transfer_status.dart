import 'package:sharehop/core/enums/base_enum.dart';

enum FileTransferStatus implements BaseEnum {
  pending(persistentValue: 'pending'),
  inProgress(persistentValue: 'in_progress'),
  completed(persistentValue: 'completed'),
  failed(persistentValue: 'failed'),
  canceled(persistentValue: 'canceled');

  new({required this.persistentValue});

  @override
  final String persistentValue;
}
