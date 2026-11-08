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
      protocol: connection.protocol,
      remoteAddress: connection.remoteAddress,
      username: connection.username,
      password: connection.password,
      displayName: connection.displayName ?? connection.remoteAddress,
    );
  }

  ConnectionModel toConnectionModel(
    ConnectionDraftDto connection, {
    required DateTime date,
  }) {
    final password = EncryptedValueModel(
      id: const Uuid().v7obj(),
      salt: '',
      cipherText: connection.password,
      nonce: '',
      mac: '',
      createdAt: date,
      updatedAt: date,
    );

    return ConnectionModel(
      id: const Uuid().v7obj(),
      displayName: connection.displayName,
      protocol: connection.protocol,
      remoteAddress: connection.remoteAddress,
      username: connection.username,
      passwordId: password.id,
      password: password,
      createdAt: date,
      updatedAt: date,
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
