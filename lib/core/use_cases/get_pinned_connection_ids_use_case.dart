import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:uuid/uuid_value.dart';

class GetPinnedConnectionIdsUseCase {
  const new({required this.pinnedConnectionRepository});

  final PinnedConnectionRepository pinnedConnectionRepository;

  Future<Set<UuidValue>> call() =>
      pinnedConnectionRepository.getPinnedConnectionIds();
}
