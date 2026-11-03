import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

class WebDavClientManager {
  new(this.clientPool);

  final WebDavClientPool clientPool;

  Future<T> useClientWithDisposal<T>(
    Future<T> Function(webdav.Client client) action, {
    required WebDavCredentialModel credential,
  }) async {
    final client = clientPool.getClient(credential: credential);

    try {
      return await action(client);
    } catch (e) {
      clientPool.destroyClient(credential: credential);
      rethrow;
    }
  }
}
