import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/repositories/connection/dto.dart';
import 'package:uuid/uuid.dart';

ConnectionModel buildConnectionDraftDtoFromConnectionModel(
  ConnectionDraftDto draft,
) {
  return ConnectionModel(
    id: const Uuid().v7(),
    displayName: draft.displayName ?? draft.remoteAddress,
    protocol: draft.connectionProtocol,
    remoteAddress: draft.remoteAddress,
    createdAt: DateTime.now().toUtc(),
    updatedAt: DateTime.now().toUtc(),
  );
}
