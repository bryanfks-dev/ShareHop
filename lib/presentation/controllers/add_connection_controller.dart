import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/di/connection_di.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid_value.dart';

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
    bool allowSelfSignedCertificate = false,
  }) async {
    state = const AsyncLoading();

    try {
      final connection = ConnectionDto(
        protocol: .webdav,
        remoteAddress: remoteAddress,
        username: username,
        password: password,
        displayName: displayName,
        rootPath: rootPath,
        allowSelfSignedCertificate: allowSelfSignedCertificate,
      );
      final savedConnection = await ref
          .read(createConnectionUseCaseProvider)
          .call(connection: connection);

      final isPinned = await ref
          .read(pinConnectionUseCaseProvider)
          .call(connectionId: savedConnection.id);

      await ref
          .read(managePinnedConnectionsControllerProvider.notifier)
          .refresh();

      final savedConnectionUI = ref
          .read(connectionMapperProvider)
          .toConnectionViewModel(savedConnection, isPinned: isPinned);

      state = AsyncData(savedConnectionUI);
      return savedConnectionUI;
    } on Object catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<ConnectionViewModel> updateWebDavConnection({
    required UuidValue id,
    required String remoteAddress,
    required String rootPath,
    required String username,
    required String password,
    String? displayName,
    bool isPinned = false,
    bool? allowSelfSignedCertificate,
  }) async {
    state = const AsyncLoading();

    try {
      final updatedConnection = await ref
          .read(updateConnectionUseCaseProvider)
          .call(
            id: id,
            remoteAddress: remoteAddress,
            rootPath: rootPath,
            username: username,
            password: password,
            displayName: displayName,
            allowSelfSignedCertificate: allowSelfSignedCertificate,
          );

      await ref
          .read(managePinnedConnectionsControllerProvider.notifier)
          .refresh();

      final updatedConnectionUI = ref
          .read(connectionMapperProvider)
          .toConnectionViewModel(updatedConnection, isPinned: isPinned);

      state = AsyncData(updatedConnectionUI);
      return updatedConnectionUI;
    } on Object catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
