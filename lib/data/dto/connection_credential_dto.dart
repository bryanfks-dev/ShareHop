import 'package:sharehop/core/enums/connection_protocol.dart';

abstract interface class ConnectionCredentialDto {
  ConnectionProtocol get protocol;
}

typedef ConnectionCredentialModel = ConnectionCredentialDto;
