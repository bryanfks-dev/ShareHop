import 'package:sharehop/core/enums/connection_protocol.dart';

extension ConnectionProtocolExtension on ConnectionProtocol {
  String get displayName {
    return switch (this) {
      ConnectionProtocol.ftp => 'FTP',
      ConnectionProtocol.sftp => 'SFTP',
      ConnectionProtocol.webdav => 'WebDAV',
      ConnectionProtocol.ftps => 'FTPS',
      ConnectionProtocol.nfs => 'NFS',
      ConnectionProtocol.smb => 'SMB',
    };
  }

  String get shortName {
    return switch (this) {
      ConnectionProtocol.ftp => 'FTP',
      ConnectionProtocol.sftp => 'SFTP',
      ConnectionProtocol.webdav => 'DAV',
      ConnectionProtocol.ftps => 'FTPS',
      ConnectionProtocol.nfs => 'NFS',
      ConnectionProtocol.smb => 'SMB',
    };
  }

  String get hint {
    return switch (this) {
      ConnectionProtocol.ftp => 'Standard file transfer',
      ConnectionProtocol.sftp => '',
      ConnectionProtocol.webdav => 'HTTP(s) document storage',
      ConnectionProtocol.ftps => 'FTP protected with transport security',
      ConnectionProtocol.nfs => '',
      ConnectionProtocol.smb => 'Local network file sharing',
    };
  }
}
