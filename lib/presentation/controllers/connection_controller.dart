import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/di/connection_di.dart';

part 'connection_controller.g.dart';

@riverpod
class ConnectionController extends _$ConnectionController {
  @override
  AsyncValue<ConnectionModel?> build() => const AsyncData(null);

  Future<ConnectionModel> addWebDavConnection({
    required String serverUrl,
    required String rootPath,
    required String username,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncLoading();

    try {
      final connection = ConnectionDto(
        connectionProtocol: .webdav,
        remoteAddress: serverUrl,
        username: username,
        password: password,
        displayName: displayName,
      );
      final savedConnection = await ref
          .read(createConnectionUseCaseProvider)
          .call(connection: connection);

      state = AsyncData(savedConnection);
      return savedConnection;
    } on Object catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
