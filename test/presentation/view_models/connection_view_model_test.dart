import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

void main() {
  group('ConnectionViewModel', () {
    test('instantiates with required properties and default status', () {
      final model = ConnectionViewModel(
        id: 'c1',
        protocol: ConnectionProtocol.webdav,
        displayName: 'My WebDAV',
        remoteAddress: 'https://dav.test',
        username: 'user1',
        password: 'pass1',
        isPinned: true,
      );

      expect(model.id, 'c1');
      expect(model.protocol, ConnectionProtocol.webdav);
      expect(model.displayName, 'My WebDAV');
      expect(model.remoteAddress, 'https://dav.test');
      expect(model.username, 'user1');
      expect(model.password, 'pass1');
      expect(model.isPinned, isTrue);
      expect(model.status, ConnectionStatus.idle);
    });

    test('mutable properties can be modified', () {
      final model = ConnectionViewModel(
        id: 'c2',
        protocol: ConnectionProtocol.smb,
        displayName: 'Old Name',
        remoteAddress: '192.168.1.1',
        username: 'oldUser',
        password: 'oldPassword',
        isPinned: false,
        status: ConnectionStatus.online,
      );

      expect(model.displayName, 'Old Name');

      model
        ..displayName = 'New Name'
        ..remoteAddress = '192.168.1.2'
        ..username = 'newUser'
        ..password = 'newPassword'
        ..isPinned = true
        ..status = ConnectionStatus.ready;

      expect(model.displayName, 'New Name');
      expect(model.remoteAddress, '192.168.1.2');
      expect(model.username, 'newUser');
      expect(model.password, 'newPassword');
      expect(model.isPinned, isTrue);
      expect(model.status, ConnectionStatus.ready);
    });
  });
}
