import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:uuid/uuid_value.dart';

abstract interface class ConnectionRepository {
  Future<List<ConnectionModel>> getAll();
  Future<ConnectionModel?> getOne(UuidValue id);
  Future<ConnectionModel> create(ConnectionModel connection);
  Future<ConnectionModel?> update({required ConnectionRevisionDto connection});
  Future<void> remove(UuidValue id);
  Future<void> batchRemove(Set<UuidValue> ids);
  Future<Set<UuidValue>> checkIfExists(Set<UuidValue> ids);
}
