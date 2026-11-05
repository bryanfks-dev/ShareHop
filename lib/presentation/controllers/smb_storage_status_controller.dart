import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/data/dto/storage_status_dto.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/di/connection_di.dart';

part 'smb_storage_status_controller.g.dart';

@riverpod
class SmbStorageStatusController extends _$SmbStorageStatusController {
  @override
  Future<StorageStatusDto> build(ConnectionModel connection) async {
    final useCase = ref.watch(getSmbStorageStatusUseCaseProvider);
    return await useCase(connection: connection);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getSmbStorageStatusUseCaseProvider);
      return await useCase(connection: connection);
    });
  }
}
