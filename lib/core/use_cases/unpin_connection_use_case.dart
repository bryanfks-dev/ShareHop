import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:uuid/uuid_value.dart';

class UnpinConnectionUseCase {
  const new({required this.pinnedConnectionRepository});

  final PinnedConnectionRepository pinnedConnectionRepository;

  Future<void> call({required UuidValue connectionId}) =>
      pinnedConnectionRepository.unpin(connectionId);
}
