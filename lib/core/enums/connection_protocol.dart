import 'package:sharehop/core/enums/base_enum.dart';

enum ConnectionProtocol implements BaseEnum {
  ftp(persistentValue: 'ftp'),
  sftp(persistentValue: 'sftp'),
  webdav(persistentValue: 'webdav'),
  ftps(persistentValue: 'ftps'),
  nfs(persistentValue: 'nfs'),
  smb(persistentValue: 'smb');

  new({required this.persistentValue});

  @override
  final String persistentValue;
}
