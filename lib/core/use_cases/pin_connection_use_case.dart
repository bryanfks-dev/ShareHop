import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:uuid/uuid_value.dart';

class PinConnectionUseCase {
  const new({required this.pinnedConnectionRepository});

  final PinnedConnectionRepository pinnedConnectionRepository;

  static const kMaxPinnedLimit = 6;

  Future<bool> call({
    required UuidValue connectionId,
    int? maxLimit = kMaxPinnedLimit,
  }) async {
    if (maxLimit != null) {
      final pinnedIds =
          await pinnedConnectionRepository.getPinnedConnectionIds();
      if (pinnedIds.length >= maxLimit) {
        return false;
      }
    }

    await pinnedConnectionRepository.pin(connectionId);
    return true;
  }
}
