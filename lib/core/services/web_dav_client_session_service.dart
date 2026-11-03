import 'package:sharehop/core/models/web_dav_credential_model.dart';

abstract interface class WebDavClientSessionService {
  void destroy({required WebDavCredentialModel credential});
}
