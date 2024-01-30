import 'package:common/exceptions/request_exception.dart';
import 'package:common/exceptions/validated_model_exception.dart';
import 'package:common/item/item.dart';
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
      final roomDb = await _roomRepository.createRoom(request);

      return Room.validated(code: roomDb.code);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Room> getRoomByCode(String code) async {
    try {
      Room.assertValidCode(code);

      final roomDB = await _roomRepository.getRoomByCode(code);

      return Room.validated(code: roomDB.code);
    } on ValidatedModelException catch (e) {
      throw BadRequestBodyException(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<Item>> getRoomItems(String code) async {
    try {
      final items = await _roomRepository.getRoomItems(code);

      return items
          .map(
            (itemDB) => Item(
              id: itemDB.id,
              name: itemDB.name,
              quantity: itemDB.quantity,
              price: itemDB.price,
              checked: itemDB.checked,
            ),
          )
          .toList();
    } on Exception {
      rethrow;
    }
  }
}
