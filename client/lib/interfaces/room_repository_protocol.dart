import 'package:common/rooms/room.dart';

abstract interface class RoomRepository {
  Future<Room> getRoomByCode(String code);
  Future<Room> createRoom(String code);
}
