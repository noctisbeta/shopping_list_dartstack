import 'package:meta/meta.dart';

@immutable
sealed class RoomEvent {
  const RoomEvent();
}

@immutable
final class CreateRoomEvent extends RoomEvent {
  const CreateRoomEvent(this.code);

  final String code;
}

@immutable
final class EnterRoomEvent extends RoomEvent {
  const EnterRoomEvent(this.code);

  final String code;
}
