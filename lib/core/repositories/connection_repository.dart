import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';

abstract interface class ConnectionRepository {
  Future<List<ConnectionModel>> getAll();
  Future<ConnectionModel?> getOne({required String id});
  Future<ConnectionModel> create({required ConnectionDraftDto connection});
  Future<ConnectionModel?> update({required ConnectionModel model});
  Future<void> remove({required String id});
  Future<void> batchRemove({required Set<String> ids});
  Future<String?> checkIfExists({required String id});
}
