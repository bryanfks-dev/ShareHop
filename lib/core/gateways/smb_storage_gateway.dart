import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/value_objects/storage_status_vo.dart';

abstract interface class SmbStorageGateway {
  Future<StorageStatusVO> getStatus({
    required ConnectionModel connection,
    String path = '/',
  });
}
