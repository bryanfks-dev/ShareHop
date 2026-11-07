import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_manager.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

class FakeWebDavClientPool extends WebDavClientPool {
  int destroyCallCount = 0;
  WebDavCredentialDto? lastDestroyedCredential;

  @override
  webdav.Client getClient({required WebDavCredentialDto credential}) {
    return webdav.newClient(
      credential.url.toString(),
      user: credential.username,
      password: credential.password,
    );
  }

  @override
  void destroyClient({required WebDavCredentialDto credential}) {
    destroyCallCount++;
    lastDestroyedCredential = credential;
  }
}

void main() {
  group('WebDavClientManager', () {
    final credential = WebDavCredentialDto(
      url: Uri.parse('https://example.com/dav'),
      username: 'user',
      password: 'pass',
    );

    test('useClientWithDisposal returns result on success', () async {
      final fakePool = FakeWebDavClientPool();
      final manager = WebDavClientManager(clientPool: fakePool);

      final result = await manager.useClientWithDisposal(
        (client) async => 'success_result',
        credential: credential,
      );

      expect(result, 'success_result');
      expect(fakePool.destroyCallCount, 0);
    });

    test(
      'useClientWithDisposal destroys client and rethrows on failure',
      () async {
        final fakePool = FakeWebDavClientPool();
        final manager = WebDavClientManager(clientPool: fakePool);

        await expectLater(
          () => manager.useClientWithDisposal(
            (client) async => throw Exception('Connection error'),
            credential: credential,
          ),
          throwsA(isA<Exception>()),
        );

        expect(fakePool.destroyCallCount, 1);
        expect(fakePool.lastDestroyedCredential, credential);
      },
    );
  });
}
