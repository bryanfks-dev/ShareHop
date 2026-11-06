import 'package:sharehop/core/models/connection_credential_model.dart';

abstract interface class ConnectionService {
  Future<void> verify({required ConnectionCredentialModel credential});
}
