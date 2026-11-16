import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:uuid/uuid_value.dart';

class DeleteConnectionUseCase {
  const new({
    required this.connectionRepository,
    required this.pinnedConnectionRepository,
  });

  final ConnectionRepository connectionRepository;
  final PinnedConnectionRepository pinnedConnectionRepository;

  Future<void> call({required UuidValue connectionId}) async {
    await pinnedConnectionRepository.unpin(connectionId);
    await connectionRepository.remove(connectionId);
  }
}
