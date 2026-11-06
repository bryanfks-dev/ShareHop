import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/data/dto/storage_status_dto.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/gateways/smb_storage_gateway.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/use_cases/get_smb_storage_status_use_case.dart';

class FakeSmbStorageGateway implements SmbStorageGateway {
  @override
  Future<StorageStatusDto> getStatus({
    required ConnectionModel connection,
    String path = '/',
  }) async {
    return const StorageStatusDto(
      totalBytes: 500 * 1024 * 1024 * 1024,
      freeBytes: 64 * 1024 * 1024 * 1024,
    );
  }
}

void main() {
  group('GetSmbStorageStatusUseCase', () {
    test('returns storage status DTO with calculated usage', () async {
      final gateway = FakeSmbStorageGateway();
      final useCase = GetSmbStorageStatusUseCase(gateway);

      final connection = ConnectionModel(
        id: '1',
        displayName: 'Studio NAS',
        remoteAddress: '192.168.1.42',
        protocol: ConnectionProtocol.smb,
        createdAt: DateTime(2023, 5, 12),
        updatedAt: DateTime(2023, 5, 12),
      );

      final result = await useCase(connection: connection);

      expect(result.totalBytes, 500 * 1024 * 1024 * 1024);
      expect(result.freeBytes, 64 * 1024 * 1024 * 1024);
      expect(result.usedBytes, 436 * 1024 * 1024 * 1024);
      expect(result.usedPercentage, closeTo(0.872, 0.01));
      expect(StorageStatusDto.formatBytes(bytes: result.totalBytes), '500 GB');
      expect(StorageStatusDto.formatBytes(bytes: result.usedBytes), '436 GB');
      expect(StorageStatusDto.formatBytes(bytes: result.freeBytes), '64 GB');
    });
  });
}
