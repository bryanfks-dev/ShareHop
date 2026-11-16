import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/errors/connection.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
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
    final existing = await _connectionRepository.getOne(id);
    if (existing == null) {
      throw UpdateConnectionFailedError();
    }

    final key = await _appConfigRepository.getEncryptionKey();
    final secretCipher = _secretCipherFactory(key);
    final encryptedPassword = await secretCipher.encrypt(password);

    final now = DateTime.now().toUtc();
    final updatedPassword = (existing.password ??
            EncryptedValueModel(
              id: existing.passwordId,
              salt: encryptedPassword.salt,
              nonce: encryptedPassword.nonce,
              cipherText: encryptedPassword.cipherText,
              mac: encryptedPassword.mac,
              createdAt: now,
              updatedAt: now,
            ))
        .copyWith(
          salt: encryptedPassword.salt,
          nonce: encryptedPassword.nonce,
          cipherText: encryptedPassword.cipherText,
          mac: encryptedPassword.mac,
          updatedAt: now,
        );

    final updatedConnection = existing.copyWith(
      protocol: protocol,
      displayName: displayName != null && displayName.isNotEmpty
          ? displayName
          : remoteAddress,
      remoteAddress: remoteAddress,
      username: username,
      password: updatedPassword,
      rootPath: rootPath,
      allowSelfSignedCertificate:
          allowSelfSignedCertificate ?? existing.allowSelfSignedCertificate,
      updatedAt: now,
    );

    final updated = await _connectionRepository.update(updatedConnection);
    if (updated == null) {
      throw UpdateConnectionFailedError();
    }
    return updated;
  }
}
