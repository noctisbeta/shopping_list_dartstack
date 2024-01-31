import 'package:common/room/create_room_request.dart';
import 'package:shopping_list_backend/item/models/item_db.dart';
import 'package:shopping_list_backend/room/models/room_db.dart';

abstract interface class RoomRepositoryProtocol {
  Future<RoomDB> createRoom(CreateRoomRequest request);
  Future<RoomDB> getRoomByCode(String code);
  Future<List<ItemDB>> getRoomItems(String code);
}
