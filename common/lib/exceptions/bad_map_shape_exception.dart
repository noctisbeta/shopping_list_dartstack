final class BadMapShapeException implements Exception {
  const BadMapShapeException(this.message);

  final String message;

  @override
  String toString() => 'BadMapShapeException: $message';
}
