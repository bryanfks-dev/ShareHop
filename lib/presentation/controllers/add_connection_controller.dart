import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

part 'add_connection_controller.g.dart';

@Riverpod(keepAlive: true)
class AddConnectionController extends _$AddConnectionController {
  @override
  AsyncValue<ConnectionViewModel?> build() => const AsyncData(null);

  Future<ConnectionViewModel> addWebDavConnection({
    required String remoteAddress,
    required String rootPath,
    required String username,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncLoading();

    try {
      final connection = ConnectionDto(
        connectionProtocol: .webdav,
        remoteAddress: remoteAddress,
        username: username,
        password: password,
        displayName: displayName,
      );
      final savedConnection = await ref
          .read(createConnectionUseCaseProvider)
          .call(connection: connection);

      final savedConnectionUI = ref
          .read(connectionMapperProvider)
          .toConnectionViewModel(savedConnection);

      state = AsyncData(savedConnectionUI);
      return savedConnectionUI;
    } on Object catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
