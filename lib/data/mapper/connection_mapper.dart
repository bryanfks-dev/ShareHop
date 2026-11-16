import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class ConnectionMapper {
  const new(this.encryptedValueMapper);

  final EncryptedValueMapper encryptedValueMapper;

  ConnectionModel toConnectionModel(Map<String, dynamic> row) {
    final password = encryptedValueMapper.toEncryptedValueModelFromRow(row);
    return ConnectionModel.fromJson(row).copyWith(password: password);
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
      rootPath: connection.rootPath,
      allowSelfSignedCertificate: connection.allowSelfSignedCertificate,
      isPinned: isPinned,
    );
  }
}
