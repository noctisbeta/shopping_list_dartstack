final class BadResponseBodyException implements Exception {
  const BadResponseBodyException(this.message);

  final String message;

  @override
  String toString() => 'BadResponseBodyException: $message';
}
