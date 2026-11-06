import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';

abstract interface class ConnectionRepository {
  Future<List<ConnectionModel>> getAll();
  Future<ConnectionModel?> getOne(String id);
  Future<ConnectionModel> create(ConnectionDraftDto connection);
  Future<ConnectionModel?> update(ConnectionModel connection);
  Future<void> remove(String id);
  Future<void> batchRemove(Set<String> ids);
  Future<String?> checkIfExists(String id);
}
