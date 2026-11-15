import 'package:sharehop/core/gateways/web_dav_client_session_gateway.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';

class WebDavClientSessionGatewayImpl implements WebDavClientSessionGateway {
  new({required this.clientPool});

  final WebDavClientPool clientPool;

  @override
  void destroy({required WebDavCredentialDto credential}) {
    clientPool.destroyClient(credential: credential);
  }
}
