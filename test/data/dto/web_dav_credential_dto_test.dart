import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';

void main() {
  group('WebDavCredentialDto', () {
    test('creates WebDavCredentialDto with correct fields', () {
      final credential = WebDavCredentialDto(
        url: Uri.parse('https://example.com/dav'),
        username: 'alice',
        password: 'secretpassword',
      );

      expect(credential.url, Uri.parse('https://example.com/dav'));
      expect(credential.username, 'alice');
      expect(credential.password, 'secretpassword');
      expect(credential.protocol, ConnectionProtocol.webdav);
    });

    test('masks password in toString', () {
      final credential = WebDavCredentialDto(
        url: Uri.parse('https://example.com/dav'),
        username: 'alice',
        password: 'secret',
      );

      expect(
        credential.toString(),
        'WebDavCredential(url: https://example.com/dav, username: alice, password: ******)',
      );
    });

    test('supports equality and copyWith', () {
      final cred1 = WebDavCredentialDto(
        url: Uri.parse('https://example.com/dav'),
        username: 'alice',
        password: 'secret',
      );
      final cred2 = WebDavCredentialDto(
        url: Uri.parse('https://example.com/dav'),
        username: 'alice',
        password: 'secret',
      );
      final cred3 = cred1.copyWith(username: 'bob');

      expect(cred1, equals(cred2));
      expect(cred1.hashCode, equals(cred2.hashCode));
      expect(cred3.username, 'bob');
      expect(cred3.url, cred1.url);
    });
  });
}
