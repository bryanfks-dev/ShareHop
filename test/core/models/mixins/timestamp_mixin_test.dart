import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/models/mixins/id_mixin.dart';
import 'package:sharehop/core/models/mixins/timestamp_mixin.dart';
import 'package:uuid/uuid.dart';

class _TestModel with IdMixin, TimestampMixin {
  new({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final UuidValue id;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;
}

void main() {
  group('IdMixin & TimestampMixin', () {
    test('IdMixin provides id', () {
      final id = const Uuid().v7obj();
      final now = DateTime.now();
      final model = _TestModel(id: id, createdAt: now, updatedAt: now);

      expect(model.id, id);
    });

    test('TimestampMixin detects wasEdited and calculates age', () {
      final id = const Uuid().v7obj();
      final created = DateTime.now().subtract(const Duration(minutes: 10));
      final updated = DateTime.now().subtract(const Duration(minutes: 2));

      final editedModel = _TestModel(
        id: id,
        createdAt: created,
        updatedAt: updated,
      );
      expect(editedModel.wasEdited, isTrue);
      expect(editedModel.age.inMinutes, greaterThanOrEqualTo(2));

      final uneditedModel = _TestModel(
        id: id,
        createdAt: created,
        updatedAt: created,
      );
      expect(uneditedModel.wasEdited, isFalse);
    });
  });
}
