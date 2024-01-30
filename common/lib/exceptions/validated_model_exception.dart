final class ValidatedModelException implements Exception {
  const ValidatedModelException(this.message);

  final String message;

  @override
  String toString() => 'ValidatedModelException: $message';
}
