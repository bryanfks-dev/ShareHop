import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid_value.dart';

void main() {
  final id1 = UuidValue.fromString('11111111-1111-1111-1111-111111111111');
  final id2 = UuidValue.fromString('22222222-2222-2222-2222-222222222222');

  group('ConnectionViewModel', () {
    test('instantiates with required properties and default status', () {
      final model = ConnectionViewModel(
        id: id1,
        protocol: ConnectionProtocol.webdav,
        displayName: 'My WebDAV',
        remoteAddress: 'https://dav.test',
        username: 'user1',
        password: 'pass1',
        isPinned: true,
      );

      expect(model.id, id1);
      expect(model.protocol, ConnectionProtocol.webdav);
      expect(model.displayName, 'My WebDAV');
      expect(model.remoteAddress, 'https://dav.test');
      expect(model.username, 'user1');
      expect(model.password, 'pass1');
      expect(model.rootPath, '/');
      expect(model.isPinned, isTrue);
      expect(model.status, ConnectionStatus.offline);
      expect(model.allowSelfSignedCertificate, isFalse);
      expect(model.validateServerCertificate, isTrue);
      expect(model.isSecure, isTrue);
      expect(model.isSecured, isTrue);
    });

    test('isSecure computes correctly based on protocol and address', () {
      final httpsDav = ConnectionViewModel(
        id: id1,
        protocol: ConnectionProtocol.webdav,
        displayName: 'HTTPS DAV',
        remoteAddress: 'https://dav.example.com',
        username: 'user',
        password: 'pwd',
        isPinned: false,
      );
      expect(httpsDav.isSecure, isTrue);
      expect(httpsDav.isSecured, isTrue);

      final httpDav = ConnectionViewModel(
        id: id1,
        protocol: ConnectionProtocol.webdav,
        displayName: 'HTTP DAV',
        remoteAddress: 'http://dav.example.com',
        username: 'user',
        password: 'pwd',
        isPinned: false,
      );
      expect(httpDav.isSecure, isFalse);
      expect(httpDav.isSecured, isFalse);

      final sftp = ConnectionViewModel(
        id: id1,
        protocol: ConnectionProtocol.sftp,
        displayName: 'SFTP',
        remoteAddress: 'sftp.example.com',
        username: 'user',
        password: 'pwd',
        isPinned: false,
      );
      expect(sftp.isSecure, isTrue);

      final ftps = ConnectionViewModel(
        id: id1,
        protocol: ConnectionProtocol.ftps,
        displayName: 'FTPS',
        remoteAddress: 'ftps.example.com',
        username: 'user',
        password: 'pwd',
        isPinned: false,
      );
      expect(ftps.isSecure, isTrue);

      final ftp = ConnectionViewModel(
        id: id1,
        protocol: ConnectionProtocol.ftp,
        displayName: 'FTP',
        remoteAddress: 'ftp.example.com',
        username: 'user',
        password: 'pwd',
        isPinned: false,
      );
      expect(ftp.isSecure, isFalse);

      final smb = ConnectionViewModel(
        id: id1,
        protocol: ConnectionProtocol.smb,
        displayName: 'SMB',
        remoteAddress: '192.168.1.10',
        username: 'user',
        password: 'pwd',
        isPinned: false,
      );
      expect(smb.isSecure, isFalse);
    });

    test('mutable properties can be modified', () {
      final model = ConnectionViewModel(
        id: id2,
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
