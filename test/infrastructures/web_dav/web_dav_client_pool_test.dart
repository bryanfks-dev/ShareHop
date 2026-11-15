import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';

void main() {
  group('WebDavClientPool', () {
    test(
      'getClient creates a client and reuses it for identical credentials',
      () {
      final pool = WebDavClientPool();
      final credential = WebDavCredentialDto(
        url: Uri.parse('https://dav.example.com'),
        username: 'user1',
        password: 'pass1',
      );

      final client1 = pool.getClient(credential: credential);
      final client2 = pool.getClient(credential: credential);

      expect(identical(client1, client2), isTrue);
    });

    test('destroyClient removes client from cache', () {
      final pool = WebDavClientPool();
      final credential = WebDavCredentialDto(
        url: Uri.parse('https://dav.example.com'),
        username: 'user2',
        password: 'pass2',
      );

      final client1 = pool.getClient(credential: credential);
      pool.destroyClient(credential: credential);

      final client2 = pool.getClient(credential: credential);
      expect(identical(client1, client2), isFalse);
    });
  });
}
