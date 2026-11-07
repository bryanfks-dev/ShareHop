import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/extensions/enums/connection_protocol_extension.dart';

void main() {
  group('ConnectionProtocolExtension', () {
    test('resolves display names correctly', () {
      expect(ConnectionProtocol.ftp.displayName, 'FTP');
      expect(ConnectionProtocol.sftp.displayName, 'SFTP');
      expect(ConnectionProtocol.webdav.displayName, 'WebDAV');
      expect(ConnectionProtocol.ftps.displayName, 'FTPS');
      expect(ConnectionProtocol.nfs.displayName, 'NFS');
      expect(ConnectionProtocol.smb.displayName, 'SMB');
    });

    test('resolves short names correctly', () {
      expect(ConnectionProtocol.ftp.shortName, 'FTP');
      expect(ConnectionProtocol.sftp.shortName, 'SFTP');
      expect(ConnectionProtocol.webdav.shortName, 'DAV');
      expect(ConnectionProtocol.ftps.shortName, 'FTPS');
      expect(ConnectionProtocol.nfs.shortName, 'NFS');
      expect(ConnectionProtocol.smb.shortName, 'SMB');
    });

    test('resolves hints correctly', () {
      expect(ConnectionProtocol.ftp.hint, 'Standard file transfer');
      expect(ConnectionProtocol.sftp.hint, isEmpty);
      expect(ConnectionProtocol.webdav.hint, 'HTTP(s) document storage');
      expect(
        ConnectionProtocol.ftps.hint,
        'FTP protected with transport security',
      );
      expect(ConnectionProtocol.nfs.hint, isEmpty);
      expect(ConnectionProtocol.smb.hint, 'Local network file sharing');
    });

    test('retains domain persistentValue', () {
      expect(ConnectionProtocol.ftp.persistentValue, 'ftp');
      expect(ConnectionProtocol.sftp.persistentValue, 'sftp');
      expect(ConnectionProtocol.webdav.persistentValue, 'webdav');
      expect(ConnectionProtocol.ftps.persistentValue, 'ftps');
      expect(ConnectionProtocol.nfs.persistentValue, 'nfs');
      expect(ConnectionProtocol.smb.persistentValue, 'smb');
    });
  });
}
