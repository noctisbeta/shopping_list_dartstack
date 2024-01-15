import 'package:common/room/create_room_request.dart';
import 'package:common/room/room.dart';
import 'package:shopping_list_backend/room/protocols/room_repository_protocol.dart';
import 'package:shopping_list_backend/room/protocols/room_service_protocol.dart';

final class RoomService implements RoomServiceProtocol {
  const RoomService({
    required RoomRepositoryProtocol roomRepository,
  }) : _roomRepository = roomRepository;

  final RoomRepositoryProtocol _roomRepository;

  @override
  Future<Room> createRoom(CreateRoomRequest request) async {
    try {
      final room = await _roomRepository.createRoom(request);

      return Room(code: room.code);
    } on FormatException {
      rethrow;
    }
  }

  @override
  Future<Room> getRoomByCode(String code) async {
    try {
      final roomDB = await _roomRepository.getRoomByCode(code);

      return Room(code: roomDB.code);
    } on Exception {
      rethrow;
    }
  }
}
