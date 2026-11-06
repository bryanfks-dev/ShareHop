import 'package:cryptography/cryptography.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/infrastructures/security/derived_key_secret_chiper.dart';
import 'package:uuid/uuid.dart';

class ConnectionMapper {
  const new(this.encryptedValueMapper);

  final EncryptedValueMapper encryptedValueMapper;

  ConnectionDraftDto toDraftDto(ConnectionDto connection) {
    return ConnectionDraftDto(
      connectionProtocol: connection.connectionProtocol,
      remoteAddress: connection.remoteAddress,
      username: connection.username,
      password: connection.password,
      displayName: connection.displayName ?? connection.remoteAddress,
    );
  }

  ConnectionModel toConnectionModel(ConnectionDraftDto connection) {
    final now = DateTime.now().toUtc();
    final secret = Argon2id(
      memory: 19 * 1024,
      parallelism: 1,
      iterations: 2,
      hashLength: 32,
    );
    final password = encryptedValueMapper.toEncryptedValueModel();

    return ConnectionModel(
      id: const Uuid().v7(),
      displayName: connection.displayName,
      protocol: connection.connectionProtocol,
      remoteAddress: connection.remoteAddress,
      username: connection.username,
      password: password,
      createdAt: now,
      updatedAt: now,
    );
  }
}
