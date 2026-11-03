import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';

abstract interface class ConnectionRepository {
  Future<List<ConnectionModel>> getAll();
  Future<ConnectionModel?> getOne(String id);
  Future<ConnectionModel> create(ConnectionDraftDto draft);
  Future<ConnectionModel?> update(ConnectionRevisionDto revision);
  Future<void> remove(String id);
  Future<void> batchRemove(Set<String> ids);
  Future<String?> checkIfExists(String id);
}
