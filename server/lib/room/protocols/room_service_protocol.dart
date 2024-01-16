import 'package:common/item/item.dart';
import 'package:common/room/create_room_request.dart';
import 'package:common/room/room.dart';

abstract interface class RoomServiceProtocol {
  Future<Room> createRoom(CreateRoomRequest request);
  Future<Room> getRoomByCode(String code);
  Future<List<Item>> getRoomItems(String code);
}
