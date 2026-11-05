import 'package:sharehop/core/data/dto/storage_status_dto.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/services/smb_storage_service.dart';

class GetSmbStorageStatusUseCase {
  const new(this._smbStorageService);

  final SmbStorageService _smbStorageService;

  Future<StorageStatusDto> call({required ConnectionModel connection}) async {
    return await _smbStorageService.getStorageStatus(connection: connection);
  }
}
