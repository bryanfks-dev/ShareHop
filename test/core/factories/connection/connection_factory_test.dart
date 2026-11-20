import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/factories/connection/factory.dart';
import 'package:sharehop/core/factories/connection/input.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';

void main() {
  group('ConnectionFactory', () {
    const password = EncryptedValue(
      salt: 'salt123',
      nonce: 'nonce123',
      cipherText: 'cipher123',
      mac: 'mac123',
    );

    test('CreateConnectionInput default values', () {
      const input = CreateConnectionInput(
        displayName: 'Test WebDav',
        remoteAddress: 'webdav.example.com',
        username: 'admin',
        password: password,
      );

      expect(input.rootPath, '/');
      expect(input.allowSelfSignedCertificate, isFalse);
    });

    test('createWebDav creates valid ConnectionModel with webdav protocol', () {
      const input = CreateConnectionInput(
        displayName: 'My Storage',
        remoteAddress: 'storage.example.com',
        username: 'user1',
        password: password,
        rootPath: '/remote.php/webdav',
        allowSelfSignedCertificate: true,
      );

      const factory = ConnectionFactory();
      final connection = factory.createWebDav(input);

      expect(connection.protocol, ConnectionProtocol.webdav);
      expect(connection.displayName, 'My Storage');
      expect(connection.remoteAddress, 'storage.example.com');
      expect(connection.username, 'user1');
      expect(connection.rootPath, '/remote.php/webdav');
      expect(connection.allowSelfSignedCertificate, isTrue);
      expect(connection.passwordId, connection.password?.id);
      expect(connection.password?.mac, password.mac);
      expect(connection.password?.cipherText, password.cipherText);
      expect(connection.password?.nonce, password.nonce);
      expect(connection.password?.salt, password.salt);
      expect(connection.id, isNotNull);
      expect(connection.createdAt, isNotNull);
      expect(connection.updatedAt, isNotNull);
    });
  });
}
