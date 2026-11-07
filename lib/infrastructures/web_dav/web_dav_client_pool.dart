import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

class WebDavClientPool {
  final _clients = <String, webdav.Client>{};

  webdav.Client getClient({required WebDavCredentialDto credential}) {
    final key =
        '${credential.url}|${credential.username}|${credential.password}';
    return _clients.putIfAbsent(
      key,
      () => _createClient(credential: credential),
    );
  }

  webdav.Client _createClient({required WebDavCredentialDto credential}) {
    return webdav.newClient(
      credential.url.toString(),
      user: credential.username,
      password: credential.password,
    );
  }

  void destroyClient({required WebDavCredentialDto credential}) {
    final key =
        '${credential.url}|${credential.username}|${credential.password}';
    final client = _clients.remove(key);
    client?.c.close();
  }
}
