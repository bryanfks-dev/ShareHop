import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/data/mapper/connection_credential_mapper.dart';

void main() {
  late ConnectionCredentialMapper mapper;

  setUp(() {
    mapper = ConnectionCredentialMapper();
  });

  group('ConnectionCredentialMapper', () {
    test('toWebDavCredentialDto maps ConnectionDto with scheme to '
        'WebDavCredentialDto', () {
      const dto = ConnectionDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://dav.example.com:8443/remote.php/webdav',
        username: 'admin',
        password: 'password',
      );

      final cred = mapper.toWebDavCredentialDto(dto);

      expect(cred, isA<WebDavCredentialDto>());
      final webDavCred = cred as WebDavCredentialDto;
      expect(webDavCred.url.scheme, 'https');
      expect(webDavCred.url.host, 'dav.example.com');
      expect(webDavCred.username, 'admin');
      expect(webDavCred.password, 'password');
    });

    test('toWebDavCredentialDto maps ConnectionDto without scheme to '
        'WebDavCredentialDto', () {
      const dto = ConnectionDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'example.com',
        username: 'user',
        password: 'pwd',
      );

      final cred = mapper.toWebDavCredentialDto(dto);

      expect(cred, isA<WebDavCredentialDto>());
      final webDavCred = cred as WebDavCredentialDto;
      expect(webDavCred.url.host, 'example.com');
      expect(webDavCred.username, 'user');
      expect(webDavCred.password, 'pwd');
    });
  });
}
