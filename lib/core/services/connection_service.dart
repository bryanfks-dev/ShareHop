import 'package:sharehop/data/dto/connection_credential_dto.dart';

abstract interface class ConnectionService {
  Future<void> verify({required ConnectionCredentialDto credential});
}
