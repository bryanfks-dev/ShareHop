import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/data/dto/web_dav_credential_dto.dart';
import 'package:sharehop/data/utils/encrypted_value.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class CheckConnectionStatusUseCase {
  const new({
    required this.connectionRepository,
    required this.appConfigRepository,
    required this.secretCipherFactory,
    required this.connectionService,
  });

  final ConnectionRepository connectionRepository;
  final AppConfigRepository appConfigRepository;
  final SecretCipherFactory secretCipherFactory;
  final ConnectionService connectionService;

  Future<ConnectionStatus> call({
    required ConnectionViewModel connection,
  }) async {
    try {
      var password = connection.password;

      try {
        final model = await connectionRepository.getOne(connection.id);
        if (model != null && model.password != null) {
          final key = await appConfigRepository.getEncryptionKey();
          final cipher = secretCipherFactory(key);
          password = await cipher.decrypt(
            EncryptedValue(
              salt: model.password!.salt,
              nonce: model.password!.nonce,
              cipherText: model.password!.cipherText,
              mac: model.password!.mac,
            ),
          );
        }
      } on Object catch (_) {
        // Fallback to connection.password
      }

      final uri = Uri.tryParse(connection.remoteAddress);
      final credential = WebDavCredentialDto(
        url: uri != null && uri.hasScheme
            ? uri
            : Uri(host: connection.remoteAddress),
        username: connection.username,
        password: password,
      );

      await connectionService.verify(credential: credential);
      return ConnectionStatus.online;
    } on Object catch (_) {
      return ConnectionStatus.offline;
    }
  }
}
