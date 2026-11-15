import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:uuid/uuid_value.dart';

class ConnectionViewModel {
  new({
    required this.id,
    required this.protocol,
    required this.displayName,
    required this.remoteAddress,
    required this.username,
    required this.password,
    required this.isPinned,
    this.rootPath = '/',
    this.allowSelfSignedCertificate = false,
    this.status = ConnectionStatus.offline,
  });

  final UuidValue id;
  final ConnectionProtocol protocol;
  String displayName;
  String remoteAddress;
  String username;
  String password;
  String rootPath;
  bool allowSelfSignedCertificate;
  bool isPinned;
  ConnectionStatus status;
}
