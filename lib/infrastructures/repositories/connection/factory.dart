import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:uuid/uuid.dart';

ConnectionModel buildConnectionDraftDtoFromConnectionModel(
  ConnectionDraftDto draft,
) {
  final trimmedDisplayName = draft.displayName?.trim();
  final displayName =
      trimmedDisplayName != null && trimmedDisplayName.isNotEmpty
          ? trimmedDisplayName
          : draft.remoteAddress;

  return ConnectionModel(
    id: const Uuid().v7(),
    displayName: displayName,
    protocol: draft.connectionProtocol,
    remoteAddress: draft.remoteAddress,
    createdAt: DateTime.now().toUtc(),
    updatedAt: DateTime.now().toUtc(),
  );
}
