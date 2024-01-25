final class BadRequestBodyException implements Exception {
  const BadRequestBodyException(this.message);

  final String message;

  @override
  String toString() => 'BadRequestBodyException: $message';
}
