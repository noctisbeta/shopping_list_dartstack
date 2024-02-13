import 'package:meta/meta.dart';

@immutable
sealed class RoomException implements Exception {
  const RoomException(this.message);

  final String message;

  @override
  String toString() => message;
}

@immutable
final class REnotFound extends RoomException {
  const REnotFound(super.message);

  @override
  String toString() => 'Room not found';
}

@immutable
final class REalreadyExists extends RoomException {
  const REalreadyExists(super.message);

  @override
  String toString() => 'Room already exists';
}

@immutable
final class REinvalidCode extends RoomException {
  const REinvalidCode(super.message);

  @override
  String toString() => 'Invalid room code';
}
