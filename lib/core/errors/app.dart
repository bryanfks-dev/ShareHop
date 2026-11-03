abstract class AppError implements Exception {
  new(this.message);

  final String message;

  @override
  String toString() => 'AppError: $message';
}
