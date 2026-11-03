import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/services/web_dav_client_session_service.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';

class WebDavClientSessionServiceImpl implements WebDavClientSessionService {
  new(this.clientPool);

  final WebDavClientPool clientPool;

  @override
  void destroy({required WebDavCredentialModel credential}) {
    clientPool.destroyClient(credential: credential);
  }
}
