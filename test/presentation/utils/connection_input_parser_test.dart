import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/utils/connection_input_parser.dart';

void main() {
  group('parseConnectionInput', () {
    test('returns default ParsedConnectionInput for empty input', () {
      final result = parseConnectionInput(input: '   ');

      expect(result.protocol, ConnectionProtocol.webdav);
      expect(result.remoteAddress, '');
      expect(result.rootPath, '/');
      expect(result.username, '');
      expect(result.password, '');
      expect(result.displayName, isNull);
    });

    test('parses bare hostname as WebDAV with https', () {
      final result = parseConnectionInput(input: 'dav.example.com');

      expect(result.protocol, ConnectionProtocol.webdav);
      expect(result.remoteAddress, 'https://dav.example.com');
      expect(result.displayName, 'dav.example.com');
      expect(result.username, '');
      expect(result.password, '');
    });

    test('parses standard https URL', () {
      final result =
          parseConnectionInput(input: 'https://dav.example.com/remote.php/webdav');

      expect(result.protocol, ConnectionProtocol.webdav);
      expect(
        result.remoteAddress,
        'https://dav.example.com/remote.php/webdav',
      );
      expect(result.displayName, 'dav.example.com');
      expect(result.rootPath, '/');
    });

    test('parses http URL with port', () {
      final result = parseConnectionInput(
        input: 'http://192.168.1.100:8080/files',
      );

      expect(result.protocol, ConnectionProtocol.webdav);
      expect(result.remoteAddress, 'http://192.168.1.100:8080/files');
      expect(result.displayName, '192.168.1.100');
    });

    test('parses webdav:// scheme with credentials', () {
      final result = parseConnectionInput(
        input: 'webdav://alice:secret123@example.com/dav',
      );

      expect(result.protocol, ConnectionProtocol.webdav);
      expect(result.remoteAddress, 'http://example.com/dav');
      expect(result.username, 'alice');
      expect(result.password, 'secret123');
      expect(result.displayName, 'example.com');
    });

    test('parses webdavs:// scheme with credentials', () {
      final result = parseConnectionInput(
        input: 'webdavs://admin:pass@storage.domain.org:8443/dav',
      );

      expect(result.protocol, ConnectionProtocol.webdav);
      expect(result.remoteAddress, 'https://storage.domain.org:8443/dav');
      expect(result.username, 'admin');
      expect(result.password, 'pass');
      expect(result.displayName, 'storage.domain.org');
    });

    test('parses sftp:// scheme with credentials and path', () {
      final result = parseConnectionInput(
        input: 'sftp://deployer:sshpass@ssh.server.io:2222/var/www',
      );

      expect(result.protocol, ConnectionProtocol.sftp);
      expect(result.remoteAddress, 'sftp://ssh.server.io:2222');
      expect(result.rootPath, '/var/www');
      expect(result.username, 'deployer');
      expect(result.password, 'sshpass');
      expect(result.displayName, 'ssh.server.io');
    });

    test('parses ftp:// scheme', () {
      final result = parseConnectionInput(input: 'ftp://ftp.example.com/pub');

      expect(result.protocol, ConnectionProtocol.ftp);
      expect(result.remoteAddress, 'ftp://ftp.example.com');
      expect(result.rootPath, '/pub');
      expect(result.displayName, 'ftp.example.com');
    });

    test('parses smb:// scheme', () {
      final result = parseConnectionInput(input: 'smb://nas.local/shared');

      expect(result.protocol, ConnectionProtocol.smb);
      expect(result.remoteAddress, 'smb://nas.local');
      expect(result.rootPath, '/shared');
    });

    test('parses url-encoded credentials correctly', () {
      final result = parseConnectionInput(
        input: 'webdav://user%40mail.com:p%40ss%23word@example.com',
      );

      expect(result.username, 'user@mail.com');
      expect(result.password, 'p@ss#word');
    });
  });
}
