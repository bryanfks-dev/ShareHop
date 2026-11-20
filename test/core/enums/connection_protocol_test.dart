import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';

void main() {
  group('ConnectionProtocol', () {
    test('contains expected enum values and persistentValues', () {
      expect(ConnectionProtocol.values, [
        ConnectionProtocol.ftp,
        ConnectionProtocol.sftp,
        ConnectionProtocol.webdav,
        ConnectionProtocol.ftps,
        ConnectionProtocol.nfs,
        ConnectionProtocol.smb,
      ]);

      expect(ConnectionProtocol.ftp.persistentValue, 'ftp');
      expect(ConnectionProtocol.sftp.persistentValue, 'sftp');
      expect(ConnectionProtocol.webdav.persistentValue, 'webdav');
      expect(ConnectionProtocol.ftps.persistentValue, 'ftps');
      expect(ConnectionProtocol.nfs.persistentValue, 'nfs');
      expect(ConnectionProtocol.smb.persistentValue, 'smb');
    });
  });
}
