import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/mapper/connection_credential_mapper.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';

class CreateConnectionUseCase {
  const new(
    this.connectionRepository,
    this.connectionService,
    this.connectionCredentialMapper,
    this.connectionMapper,
  );

  final ConnectionRepository connectionRepository;
  final ConnectionService connectionService;
  final ConnectionCredentialMapper connectionCredentialMapper;
  final ConnectionMapper connectionMapper;

  Future<ConnectionModel> call({required ConnectionDto connection}) async {
    final credential = connectionCredentialMapper.toWebDavCredentialModel(
      connection,
    );
    await connectionService.verify(credential: credential);

    final draft = connectionMapper.toDraftDto(connection);
    return await connectionRepository.create(draft);
  }
}
