import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:sharehop/di/connection_di.dart';

part 'add_connection_controller.g.dart';

@riverpod
class AddConnectionController extends _$AddConnectionController {
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
      final parsedUri = Uri.parse(serverUrl);
      final credential = WebDavCredentialModel(
        url: parsedUri,
        username: username,
        password: password,
      );

      await ref
          .read(testWebDavConnectionUseCaseProvider)
          .call(credential: credential);

      final draft = ConnectionDraftDto(
        connectionProtocol: .webdav,
        remoteAddress: serverUrl,
        displayName: displayName != null && displayName.trim().isNotEmpty
            ? displayName.trim()
            : null,
      );

      final connection = await ref
          .read(createConnectionUseCaseProvider)
          .call(draft: draft);

      state = AsyncData(connection);
      return connection;
    } on Object catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
