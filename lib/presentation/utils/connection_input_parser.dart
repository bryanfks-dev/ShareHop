import 'package:sharehop/core/enums/connection_protocol.dart';

class ParsedConnectionInput {
  const new({
    this.protocol = ConnectionProtocol.webdav,
    this.remoteAddress = '',
    this.rootPath = '/',
    this.username = '',
    this.password = '',
    this.displayName,
  });

  final ConnectionProtocol protocol;
  final String remoteAddress;
  final String rootPath;
  final String username;
  final String password;
  final String? displayName;
}

ParsedConnectionInput parseConnectionInput({required String input}) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) {
    return const ParsedConnectionInput();
  }

  var scheme = '';
  var remaining = trimmed;

  final schemeMatch =
      RegExp(r'^([a-zA-Z][a-zA-Z0-9+\-.]*):\/\/').firstMatch(trimmed);
  if (schemeMatch != null) {
    scheme = schemeMatch.group(1)!.toLowerCase();
    remaining = trimmed.substring(schemeMatch.end);
  }

  final protocol = switch (scheme) {
    'sftp' => ConnectionProtocol.sftp,
    'ftp' => ConnectionProtocol.ftp,
    'ftps' => ConnectionProtocol.ftps,
    'smb' => ConnectionProtocol.smb,
    'nfs' => ConnectionProtocol.nfs,
    _ => ConnectionProtocol.webdav,
  };

  final isSecure = scheme == 'webdavs' ||
      scheme == 'davs' ||
      scheme == 'https' ||
      scheme.isEmpty;
  final httpScheme = isSecure ? 'https' : 'http';

  final uriToParse = scheme.isNotEmpty ? trimmed : '$httpScheme://$remaining';
  final uri = Uri.tryParse(uriToParse);

  if (uri == null || (uri.host.isEmpty && !trimmed.contains('/'))) {
    return ParsedConnectionInput(
      protocol: protocol,
      remoteAddress: trimmed,
    );
  }

  var username = '';
  var password = '';
  if (uri.userInfo.isNotEmpty) {
    final userParts = uri.userInfo.split(':');
    username = Uri.decodeComponent(userParts[0]);
    if (userParts.length > 1) {
      password = Uri.decodeComponent(userParts.sublist(1).join(':'));
    }
  }

  if (protocol == ConnectionProtocol.webdav) {
    final host = uri.host.isNotEmpty ? uri.host : remaining;
    final portPart = uri.hasPort ? ':${uri.port}' : '';
    final pathPart = uri.path;
    final effectiveHttpScheme =
        (scheme == 'http' || scheme == 'webdav' || scheme == 'dav')
            ? 'http'
            : 'https';
    final remoteAddress = '$effectiveHttpScheme://$host$portPart$pathPart';

    return ParsedConnectionInput(
      protocol: protocol,
      remoteAddress: remoteAddress,
      username: username,
      password: password,
      displayName: uri.host.isNotEmpty ? uri.host : null,
    );
  }

  final remoteAddress = scheme.isNotEmpty
      ? '$scheme://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}'
      : remaining;
  final rootPath = uri.path.isNotEmpty ? uri.path : '/';

  return ParsedConnectionInput(
    protocol: protocol,
    remoteAddress: remoteAddress,
    rootPath: rootPath,
    username: username,
    password: password,
    displayName: uri.host.isNotEmpty ? uri.host : null,
  );
}
