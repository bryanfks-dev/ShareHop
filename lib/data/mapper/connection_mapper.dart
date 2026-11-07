import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
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
    final password = EncryptedValueModel(
      id: const Uuid().v7(),
      salt: '',
      cipherText: connection.password,
      nonce: '',
      mac: '',
      createdAt: now,
      updatedAt: now,
    );

    return ConnectionModel(
      id: const Uuid().v7(),
      displayName: connection.displayName,
      protocol: connection.connectionProtocol,
      remoteAddress: connection.remoteAddress,
      username: connection.username,
      passwordId: password.id,
      password: password,
      createdAt: now,
      updatedAt: now,
    );
  }

  ConnectionViewModel toConnectionViewModel(
    ConnectionModel connection, {
    bool isPinned = false,
  }) {
    return ConnectionViewModel(
      id: connection.id,
      displayName: connection.displayName,
      protocol: connection.protocol,
      remoteAddress: connection.remoteAddress,
      username: connection.username,
      password: connection.password?.cipherText ?? '',
      isPinned: isPinned,
    );
  }
}
