import 'package:common/rooms/room.dart';
import 'package:meta/meta.dart';

@immutable
sealed class RoomState {
  const RoomState();
}

@immutable
final class RSinitial extends RoomState {
  const RSinitial();
}

@immutable
final class RSloading extends RoomState {
  const RSloading();
}

@immutable
final class RScreated extends RoomState {
  const RScreated({required this.room});

  final Room room;
}

@immutable
final class RSerror extends RoomState {
  const RSerror(this.message);

  final String message;
}

@immutable
final class RSentered extends RoomState {
  const RSentered({required this.room});

  final Room room;
}

@immutable
final class RSalreadyExists extends RoomState {
  const RSalreadyExists({required this.room});

  final Room room;
}

@immutable
final class RSnotFound extends RoomState {
  const RSnotFound();
}
