import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_status.dart';

void main() {
  group('ConnectionStatus', () {
    test('contains expected enum values and persistentValues', () {
      expect(ConnectionStatus.values, [
        ConnectionStatus.online,
        ConnectionStatus.ready,
        ConnectionStatus.idle,
        ConnectionStatus.offline,
      ]);

      expect(ConnectionStatus.online.persistentValue, 'online');
      expect(ConnectionStatus.ready.persistentValue, 'ready');
      expect(ConnectionStatus.idle.persistentValue, 'idle');
      expect(ConnectionStatus.offline.persistentValue, 'offline');
    });
  });
}
