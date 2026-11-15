import 'package:sharehop/core/enums/connection_status.dart';

extension ConnectionStatusExtension on ConnectionStatus {
  String get label {
    return switch (this) {
      ConnectionStatus.online => 'Online',
      ConnectionStatus.ready => 'Ready',
      ConnectionStatus.idle => 'Idle',
      ConnectionStatus.offline => 'Offline',
    };
  }
}
