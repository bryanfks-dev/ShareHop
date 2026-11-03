import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:sharehop/core/repositories/connection/repository.dart';

class CreateConnectionUseCase {
  const new(this._connectionRepository);

  final ConnectionRepository _connectionRepository;

  Future<ConnectionModel> call({
    required ConnectionDraftDto draft,
  }) async =>
      await _connectionRepository.create(draft);
}
