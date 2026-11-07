import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/extensions/enums/connection_status_extension.dart';

void main() {
  group('ConnectionStatusExtension', () {
    test('resolves labels correctly', () {
      expect(ConnectionStatus.online.label, 'Online');
      expect(ConnectionStatus.ready.label, 'Ready');
      expect(ConnectionStatus.idle.label, 'Idle');
      expect(ConnectionStatus.offline.label, 'Offline');
    });

    test('retains domain persistentValue', () {
      expect(ConnectionStatus.online.persistentValue, 'online');
      expect(ConnectionStatus.ready.persistentValue, 'ready');
      expect(ConnectionStatus.idle.persistentValue, 'idle');
      expect(ConnectionStatus.offline.persistentValue, 'offline');
    });
  });
}
