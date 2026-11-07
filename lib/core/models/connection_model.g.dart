// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectionModel _$ConnectionModelFromJson(Map<String, dynamic> json) =>
    _ConnectionModel(
      id: json['id'] as String,
      protocol: $enumDecode(_$ConnectionProtocolEnumMap, json['protocol']),
      displayName: json['display_name'] as String,
      remoteAddress: json['remote_address'] as String,
      username: json['username'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      passwordId: json['password'] as String? ?? '',
      rootPath: json['root_path'] as String? ?? '/',
    );

Map<String, dynamic> _$ConnectionModelToJson(_ConnectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'protocol': _$ConnectionProtocolEnumMap[instance.protocol]!,
      'display_name': instance.displayName,
      'remote_address': instance.remoteAddress,
      'username': instance.username,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'password': instance.passwordId,
      'root_path': instance.rootPath,
    };

const _$ConnectionProtocolEnumMap = {
  ConnectionProtocol.ftp: 'ftp',
  ConnectionProtocol.sftp: 'sftp',
  ConnectionProtocol.webdav: 'webdav',
  ConnectionProtocol.ftps: 'ftps',
  ConnectionProtocol.nfs: 'nfs',
  ConnectionProtocol.smb: 'smb',
};
