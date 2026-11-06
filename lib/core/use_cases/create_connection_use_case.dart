import 'package:sharehop/core/models/connection_credential_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:sharehop/core/repositories/connection/repository.dart';
import 'package:sharehop/core/use_cases/test_connection_use_case.dart';

class CreateConnectionUseCase {
  const new(
    this._connectionRepository, [
    this._testConnectionUseCase,
  ]);

  final ConnectionRepository _connectionRepository;
  final TestConnectionUseCase? _testConnectionUseCase;

  Future<ConnectionModel> call({
    required ConnectionDraftDto draft,
    ConnectionCredentialModel? credential,
  }) async {
    if (credential != null && _testConnectionUseCase != null) {
      if (_testConnectionUseCase.isSupported(credential)) {
        await _testConnectionUseCase.call(credential: credential);
      }
    }

    return await _connectionRepository.create(draft);
  }
}
