mixin TimestampMixin {
  DateTime get createdAt;
  DateTime get updatedAt;

  bool get wasEdited => updatedAt.isAfter(createdAt);
  Duration get age => DateTime.now().difference(updatedAt);
}
