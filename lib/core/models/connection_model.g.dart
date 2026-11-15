// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectionModel _$ConnectionModelFromJson(Map<String, dynamic> json) =>
    _ConnectionModel(
      id: const UuidValueConverter().fromJson(json['id'] as String),
      protocol: $enumDecode(_$ConnectionProtocolEnumMap, json['protocol']),
      displayName: json['display_name'] as String,
      remoteAddress: json['remote_address'] as String,
      username: json['username'] as String,
      passwordId: const UuidValueConverter().fromJson(
        json['password_id'] as String,
      ),
      rootPath: json['root_path'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      allowSelfSignedCertificate: json['allow_self_signed_certificate'] == null
          ? false
          : const BoolIntConverter().fromJson(
              (json['allow_self_signed_certificate'] as num).toInt(),
            ),
    );

Map<String, dynamic> _$ConnectionModelToJson(_ConnectionModel instance) =>
    <String, dynamic>{
      'id': const UuidValueConverter().toJson(instance.id),
      'protocol': _$ConnectionProtocolEnumMap[instance.protocol]!,
      'display_name': instance.displayName,
      'remote_address': instance.remoteAddress,
      'username': instance.username,
      'password_id': const UuidValueConverter().toJson(instance.passwordId),
      'root_path': instance.rootPath,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'allow_self_signed_certificate': const BoolIntConverter().toJson(
        instance.allowSelfSignedCertificate,
      ),
    };

const _$ConnectionProtocolEnumMap = {
  ConnectionProtocol.ftp: 'ftp',
  ConnectionProtocol.sftp: 'sftp',
  ConnectionProtocol.webdav: 'webdav',
  ConnectionProtocol.ftps: 'ftps',
  ConnectionProtocol.nfs: 'nfs',
  ConnectionProtocol.smb: 'smb',
};
