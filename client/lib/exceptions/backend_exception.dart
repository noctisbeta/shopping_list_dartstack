import 'package:meta/meta.dart';

@immutable
sealed class BackendException implements Exception {
  const BackendException(this.message);

  final String message;

  @override
  String toString() => message;
}

@immutable
final class BEinvalidResponse extends BackendException {
  const BEinvalidResponse(super.message);

  @override
  String toString() => 'Invalid response from backend';
}
