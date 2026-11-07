import 'package:sharehop/data/dto/web_dav_credential_dto.dart';

abstract interface class WebDavClientSessionGateway {
  void destroy({required WebDavCredentialDto credential});
}
