import 'package:sharehop/core/factories/connection/factory.dart';
import 'package:sharehop/core/factories/connection/input.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/data/dto/connection_dto.dart';

class CreateConnectionUseCase {
  const new({
    required this._appConfigRepository,
    required this._connectionRepository,
    required this._secretCipherFactory,
    required this._connectionFactory,
  });

  final AppConfigRepository _appConfigRepository;
  final ConnectionRepository _connectionRepository;
  final SecretCipherFactory _secretCipherFactory;
  final ConnectionFactory _connectionFactory;

  Future<ConnectionModel> call({required ConnectionDto connection}) async {
    final key = await _appConfigRepository.getEncryptionKey();
    final secretCipher = _secretCipherFactory(key);
    final password = await secretCipher.encrypt(connection.password);

    final input = CreateConnectionInput(
      displayName: connection.displayName ?? connection.remoteAddress,
      remoteAddress: connection.remoteAddress,
      username: connection.username,
      password: password,
      rootPath: connection.rootPath,
      allowSelfSignedCertificate: connection.allowSelfSignedCertificate,
    );
    final newConnection = _connectionFactory.createWebDav(input);
    return await _connectionRepository.create(newConnection);
  }
}
