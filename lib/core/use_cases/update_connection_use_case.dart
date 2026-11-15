import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/errors/connection.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/utils/not_required_value.dart';
import 'package:uuid/uuid_value.dart';

class UpdateConnectionUseCase {
  const new({
    required this._appConfigRepository,
    required this._connectionRepository,
    required this._secretCipherFactory,
  });

  final AppConfigRepository _appConfigRepository;
  final ConnectionRepository _connectionRepository;
  final SecretCipherFactory _secretCipherFactory;

  Future<ConnectionModel> call({
    required UuidValue id,
    required String remoteAddress,
    required String rootPath,
    required String username,
    required String password,
    String? displayName,
    bool? allowSelfSignedCertificate,
    ConnectionProtocol protocol = ConnectionProtocol.webdav,
  }) async {
    final key = await _appConfigRepository.getEncryptionKey();
    final secretCipher = _secretCipherFactory(key);
    final encryptedPassword = await secretCipher.encrypt(password);

    final revision = ConnectionRevisionDto(
      id: id.uuid,
      protocol: NotRequiredValue(protocol),
      remoteAddress: NotRequiredValue(remoteAddress),
      rootPath: NotRequiredValue(rootPath),
      username: NotRequiredValue(username),
      password: NotRequiredValue(encryptedPassword.cipherText),
      displayName: NotRequiredValue(
        displayName != null && displayName.isNotEmpty
            ? displayName
            : remoteAddress,
      ),
      allowSelfSignedCertificate: allowSelfSignedCertificate != null
          ? NotRequiredValue(allowSelfSignedCertificate)
          : null,
    );

    final updated = await _connectionRepository.update(connection: revision);
    if (updated == null) {
      throw UpdateConnectionFailedError();
    }
    return updated;
  }
}
