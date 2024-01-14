import 'package:common/room/create_room_request.dart';
import 'package:common/room/room.dart';

import '../protocols/room_repository_protocol.dart';
import '../protocols/room_service_protocol.dart';

final class RoomService implements RoomServiceProtocol {
  const RoomService({
    required RoomRepositoryProtocol roomRepository,
  }) : _roomRepository = roomRepository;

  final RoomRepositoryProtocol _roomRepository;

  @override
  void createRoom(CreateRoomRequest request) {
    _roomRepository.createRoom(request);
  }

  @override
  Future<Room> getRoomByCode(String code) async {
    try {
      final roomDB = await _roomRepository.getRoomByCode(code);

      return Room(code: roomDB.code);
    } catch (e) {
      rethrow;
    }
  }
}
