import 'package:common/room/create_room_request.dart';

import '../models/room_db.dart';

abstract interface class RoomRepositoryProtocol {
  Future<void> createRoom(CreateRoomRequest request);
  void getRoomById(int id);
  Future<RoomDB> getRoomByCode(String code);
}
