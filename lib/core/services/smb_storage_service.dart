import 'package:sharehop/core/data/dto/storage_status_dto.dart';
import 'package:sharehop/core/models/connection_model.dart';

abstract interface class SmbStorageService {
  Future<StorageStatusDto> getStorageStatus({
    required ConnectionModel connection,
  });
}
