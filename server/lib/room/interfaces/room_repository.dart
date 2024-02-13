import 'package:common/items/item.dart';
import 'package:common/rooms/create_room_request.dart';
import 'package:common/rooms/room.dart';

abstract interface class RoomRepository {
  Future<Room> createRoom(CreateRoomRequest request);
  Future<Room> getRoomByCode(String code);
  Future<List<Item>> getRoomItems(String code);
}
