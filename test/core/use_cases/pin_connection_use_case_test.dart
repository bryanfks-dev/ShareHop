import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/models/pinned_connection_model.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:sharehop/core/use_cases/pin_connection_use_case.dart';
import 'package:uuid/uuid.dart';

class FakePinnedConnectionRepository implements PinnedConnectionRepository {
  final Set<UuidValue> pinnedIds = {};

  @override
  Future<List<PinnedConnectionModel>> getAll() async {
    final now = DateTime.now().toUtc();
    return pinnedIds
        .map(
          (id) => PinnedConnectionModel(
            connectionId: id,
            createdAt: now,
            updatedAt: now,
          ),
        )
        .toList();
  }

  @override
  Future<Set<UuidValue>> getPinnedConnectionIds() async => Set.from(pinnedIds);

  @override
  Future<void> pin(UuidValue connectionId) async {
    pinnedIds.add(connectionId);
  }

  @override
  Future<void> unpin(UuidValue connectionId) async {
    pinnedIds.remove(connectionId);
  }
}

void main() {
  group('PinConnectionUseCase', () {
    late FakePinnedConnectionRepository repository;
    late PinConnectionUseCase useCase;

    setUp(() {
      repository = FakePinnedConnectionRepository();
      useCase = PinConnectionUseCase(pinnedConnectionRepository: repository);
    });

    test('pins connection and returns true when under limit', () async {
      final id = UuidValue.fromString(const Uuid().v4());
      final result = await useCase.call(connectionId: id);

      expect(result, isTrue);
      expect(repository.pinnedIds, contains(id));
    });

    test('does not pin connection and returns false when at limit', () async {
      for (var i = 0; i < PinConnectionUseCase.kMaxPinnedLimit; i++) {
        repository.pinnedIds.add(UuidValue.fromString(const Uuid().v4()));
      }

      final newId = UuidValue.fromString(const Uuid().v4());
      final result = await useCase.call(connectionId: newId);

      expect(result, isFalse);
      expect(repository.pinnedIds, isNot(contains(newId)));
      expect(repository.pinnedIds.length, PinConnectionUseCase.kMaxPinnedLimit);
    });

    test('respects custom maxLimit', () async {
      const customLimit = 2;
      for (var i = 0; i < customLimit; i++) {
        repository.pinnedIds.add(UuidValue.fromString(const Uuid().v4()));
      }

      final newId = UuidValue.fromString(const Uuid().v4());
      final result = await useCase.call(
        connectionId: newId,
        maxLimit: customLimit,
      );

      expect(result, isFalse);
      expect(repository.pinnedIds, isNot(contains(newId)));
    });

    test('pins connection when maxLimit is null', () async {
      for (var i = 0; i < 10; i++) {
        repository.pinnedIds.add(UuidValue.fromString(const Uuid().v4()));
      }

      final newId = UuidValue.fromString(const Uuid().v4());
      final result = await useCase.call(connectionId: newId, maxLimit: null);

      expect(result, isTrue);
      expect(repository.pinnedIds, contains(newId));
    });
  });
}
