import 'package:sharehop/core/enums/base_enum.dart';

enum ConnectionProtocol implements BaseEnum {
  ftp(
    shortName: 'FTP',
    name: 'FTP',
    hint: 'Standard file transfer',
    persistentValue: 'ftp',
  ),
  sftp(shortName: 'SFTP', name: 'SFTP', hint: '', persistentValue: 'sftp'),
  webdav(
    shortName: 'DAV',
    name: 'WebDAV',
    hint: 'HTTP(s) document storage',
    persistentValue: 'webdav',
  ),
  ftps(
    shortName: 'FTPS',
    name: 'FTPS',
    hint: 'FTP protected with transport security',
    persistentValue: 'ftps',
  ),
  nfs(shortName: 'NFS', name: 'NFS', hint: '', persistentValue: 'nfs'),
  smb(
    shortName: 'SMB',
    name: 'SMB',
    hint: 'Local network file sharing',
    persistentValue: 'smb',
  );

  new({
    required this.shortName,
    required this.name,
    required this.hint,
    required this.persistentValue,
  });

  final String shortName;
  final String name;
  final String hint;
  @override
  final String persistentValue;
}
