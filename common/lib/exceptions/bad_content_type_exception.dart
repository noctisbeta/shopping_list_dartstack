final class BadContentTypeException implements Exception {
  const BadContentTypeException(this.message);

  final String message;

  @override
  String toString() => 'BadContentTypeException: $message';
}
