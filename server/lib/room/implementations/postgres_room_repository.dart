import 'package:common/exceptions/data_validation_exception.dart';
import 'package:common/exceptions/request_exception.dart';
import 'package:common/items/item.dart';
import 'package:common/rooms/create_room_request.dart';
import 'package:common/rooms/room.dart';
import 'package:shopping_list_backend/room/interfaces/room_data_source.dart';
import 'package:shopping_list_backend/room/interfaces/room_repository.dart';

final class PostgresRoomRepository implements RoomRepository {
  const PostgresRoomRepository({
    required RoomDataSource roomDataSource,
  }) : _roomDataSource = roomDataSource;

  final RoomDataSource _roomDataSource;

  @override
  Future<Room> createRoom(CreateRoomRequest request) async {
    final roomDb = await _roomDataSource.createRoom(request);

    return Room.validated(code: roomDb.code);
  }

  @override
  Future<Room> getRoomByCode(String code) async {
    try {
      Room.assertValidCode(code);

      final roomDB = await _roomDataSource.getRoomByCode(code);

      return Room.validated(code: roomDB.code);
    } on DataValidationException catch (e) {
      throw BadRequestBodyException(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<Item>> getRoomItems(String code) async {
    try {
      final items = await _roomDataSource.getRoomItems(code);

      return items
          .map(
            (itemDB) => Item.validated(
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
