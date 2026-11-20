import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/data/dto/connection_dto.dart';

void main() {
  group('ConnectionDto', () {
    test('instantiates with defaults and provides connectionProtocol', () {
      const dto = ConnectionDto(
        protocol: ConnectionProtocol.webdav,
        remoteAddress: 'example.com',
        username: 'user',
        password: 'secret_password',
      );

      expect(dto.protocol, ConnectionProtocol.webdav);
      expect(dto.connectionProtocol, ConnectionProtocol.webdav);
      expect(dto.remoteAddress, 'example.com');
      expect(dto.username, 'user');
      expect(dto.password, 'secret_password');
      expect(dto.displayName, isNull);
      expect(dto.rootPath, '/');
      expect(dto.allowSelfSignedCertificate, isFalse);
    });

    test('supports custom values and copyWith', () {
      const dto = ConnectionDto(
        protocol: ConnectionProtocol.sftp,
        remoteAddress: 'sftp.example.com',
        username: 'admin',
        password: 'pass',
        displayName: 'Custom Name',
        rootPath: '/home/admin',
        allowSelfSignedCertificate: true,
      );

      expect(dto.displayName, 'Custom Name');
      expect(dto.rootPath, '/home/admin');
      expect(dto.allowSelfSignedCertificate, isTrue);

      final updated = dto.copyWith(displayName: 'Updated Name');
      expect(updated.displayName, 'Updated Name');
      expect(updated.remoteAddress, 'sftp.example.com');
    });
  });
}
