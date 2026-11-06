import 'package:sharehop/core/models/web_dav_credential_model.dart';

abstract interface class WebDavClientSessionGateway {
  void destroy({required WebDavCredentialModel credential});
}
