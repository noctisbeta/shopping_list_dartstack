import 'package:common/room/create_room_request.dart';
import 'package:common/room/room.dart';

abstract interface class RoomServiceProtocol {
  void createRoom(CreateRoomRequest request);
  Future<Room> getRoomByCode(String code);
}
