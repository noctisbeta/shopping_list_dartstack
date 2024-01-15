import 'package:common/room/create_room_request.dart';
import 'package:shopping_list_backend/room/models/room_db.dart';

abstract interface class RoomRepositoryProtocol {
  Future<RoomDB> createRoom(CreateRoomRequest request);
  void getRoomById(int id);
  Future<RoomDB> getRoomByCode(String code);
}
