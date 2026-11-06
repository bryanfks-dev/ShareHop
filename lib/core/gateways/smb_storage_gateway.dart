import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/data/dto/storage_status_dto.dart';

abstract interface class SmbStorageGateway {
  Future<StorageStatusDto> getStatus({
    required ConnectionModel connection,
    String path = '/',
  });
}
