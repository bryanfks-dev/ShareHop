import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:uuid/uuid_value.dart';

abstract interface class PinnedConnectionRepository {
  Future<List<PinnedConnectionModel>> getAll();
  Future<Set<UuidValue>> getPinnedConnectionIds();
  Future<void> pin(UuidValue connectionId);
  Future<void> unpin(UuidValue connectionId);
}
