import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/mapper/connection_credential_mapper.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';

class CreateConnectionUseCase {
  const new({
    required this._connectionRepository,
    required this._connectionService,
    required this._connectionCredentialMapper,
    required this._connectionMapper,
  });

  final ConnectionRepository _connectionRepository;
  final ConnectionService _connectionService;
  final ConnectionCredentialMapper _connectionCredentialMapper;
  final ConnectionMapper _connectionMapper;

  Future<ConnectionModel> call({required ConnectionDto connection}) async {
    final credential = _connectionCredentialMapper.toWebDavCredentialDto(
      connection,
    );
    await _connectionService.verify(credential: credential);

    final draft = _connectionMapper.toDraftDto(connection);
    return await _connectionRepository.create(connection: draft);
  }
}
