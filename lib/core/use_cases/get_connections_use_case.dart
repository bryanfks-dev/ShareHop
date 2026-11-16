import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';

class GetConnectionsUseCase {
  const new({required this.connectionRepository});

  final ConnectionRepository connectionRepository;

  Future<List<ConnectionModel>> call() => connectionRepository.getAll();
}
