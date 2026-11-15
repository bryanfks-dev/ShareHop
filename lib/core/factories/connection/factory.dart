import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/factories/connection/input.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';
import 'package:uuid/uuid.dart';

class ConnectionFactory {
  const new();

  ConnectionModel createWebDav(CreateConnectionInput input) {
    final date = DateTime.now();
    return _createConnection(input, protocol: .webdav, date: date);
  }

  ConnectionModel _createConnection(
    CreateConnectionInput input, {
    required ConnectionProtocol protocol,
    required DateTime date,
  }) {
    final password = _createEncryptedPasswordValue(input.password, date: date);
    return ConnectionModel(
      id: const Uuid().v7obj(),
      protocol: protocol,
      displayName: input.displayName,
      remoteAddress: input.remoteAddress,
      username: input.username,
      passwordId: password.id,
      password: password,
      rootPath: input.rootPath,
      allowSelfSignedCertificate: input.allowSelfSignedCertificate,
      createdAt: date,
      updatedAt: date,
    );
  }

  EncryptedValueModel _createEncryptedPasswordValue(
    EncryptedValue password, {
    required DateTime date,
  }) {
    return EncryptedValueModel(
      id: const Uuid().v7obj(),
      mac: password.mac,
      nonce: password.nonce,
      salt: password.salt,
      cipherText: password.cipherText,
      createdAt: date,
      updatedAt: date,
    );
  }
}
