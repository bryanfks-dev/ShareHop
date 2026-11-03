import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

class WebDavClientPool {
  final _clients = <String, webdav.Client>{};

  webdav.Client getClient({required WebDavCredentialModel credential}) {
    final key =
        '${credential.url}|${credential.username}|${credential.password}';
    return _clients.putIfAbsent(
      key,
      () => _createClient(credential: credential),
    );
  }

  webdav.Client _createClient({required WebDavCredentialModel credential}) {
    return webdav.newClient(
      credential.url.toString(),
      user: credential.username,
      password: credential.password,
    );
  }

  void destroyClient({required WebDavCredentialModel credential}) {
    final key =
        '${credential.url}|${credential.username}|${credential.password}';
    final client = _clients.remove(key);
    client?.c.close();
  }
}
