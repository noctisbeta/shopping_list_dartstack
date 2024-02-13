import 'package:common/rooms/create_room_request.dart';
import 'package:common/rooms/create_room_response.dart';
import 'package:common/rooms/get_room_request.dart';
import 'package:common/rooms/get_room_response.dart';

abstract interface class RoomDataSource {
  Future<GetRoomResponse> getRoomByCode(GetRoomRequest request);
  Future<CreateRoomResponse> createRoom(CreateRoomRequest request);
}
