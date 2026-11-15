import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_client_session_gateway_impl.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';

class FakeWebDavClientPool extends WebDavClientPool {
  WebDavCredentialDto? destroyedCredential;

  @override
  void destroyClient({required WebDavCredentialDto credential}) {
    destroyedCredential = credential;
  }
}

void main() {
  group('WebDavClientSessionGatewayImpl', () {
    test('destroy delegates to clientPool.destroyClient', () {
      final fakePool = FakeWebDavClientPool();
      final gateway = WebDavClientSessionGatewayImpl(clientPool: fakePool);

      final credential = WebDavCredentialDto(
        url: Uri.parse('https://example.com/dav'),
        username: 'alice',
        password: 'secret_password',
      );

      gateway.destroy(credential: credential);

      expect(fakePool.destroyedCredential, credential);
    });
  });
}
