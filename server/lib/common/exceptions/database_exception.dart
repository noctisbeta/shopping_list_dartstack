sealed class DatabaseException implements Exception {
  const DatabaseException(this.message);

  final String message;

  @override
  String toString() => 'DatabaseException: $message';
}

final class DatabaseUniqueViolationException extends DatabaseException {
  const DatabaseUniqueViolationException(super.message);
}

final class DatabaseUnknownException extends DatabaseException {
  const DatabaseUnknownException(super.message);
}

final class DatabaseBadCertificateException extends DatabaseException {
  const DatabaseBadCertificateException(super.message);
}

final class DatabaseSchemaException extends DatabaseException {
  const DatabaseSchemaException(super.message);
}
