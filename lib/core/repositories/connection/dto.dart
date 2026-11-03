import 'package:sharehop/core/enums/connection_protocol.dart';

class ConnectionDraftDto {
  const new({
    required this.connectionProtocol,
    required this.remoteAddress,
    this.displayName,
  });

  final ConnectionProtocol connectionProtocol;
  final String? displayName;
  final String remoteAddress;
}

class ConnectionRevisionDto {
  const new({required this.id, this.remoteAddress, this.displayName});

  final String id;
  final String? displayName;
  final String? remoteAddress;
}
