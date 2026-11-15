abstract class AppError implements Exception {
  new({required this.message});

  final String message;

  @override
  String toString() => 'AppError: $message';
}
