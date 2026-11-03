abstract class BaseModel {
  const new({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  static String get tableName =>
      throw UnimplementedError('tableName must be implemented in subclasses');
}
