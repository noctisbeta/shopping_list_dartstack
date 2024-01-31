import 'package:common/exceptions/propagates.dart';
import 'package:common/exceptions/throws.dart';
import 'package:common/room/create_room_request.dart';
import 'package:postgres/postgres.dart';
import 'package:shopping_list_backend/common/exceptions/database_exception.dart';
import 'package:shopping_list_backend/common/implementations/postgres_service.dart';
import 'package:shopping_list_backend/common/util/result_extension.dart';
import 'package:shopping_list_backend/item/models/item_db.dart';
import 'package:shopping_list_backend/room/models/room_db.dart';
import 'package:shopping_list_backend/room/protocols/room_repository_protocol.dart';

final class RoomRepository implements RoomRepositoryProtocol {
  const RoomRepository({
    required PostgresService database,
  }) : _db = database;

  final PostgresService _db;

  @override
  @Propagates([DatabaseException])
  Future<RoomDB> createRoom(CreateRoomRequest request) async {
    final res = await _db.execute(
      Sql.named('INSERT INTO rooms (code) VALUES (@code) RETURNING *;'),
      parameters: {'code': request.code},
    );

    final firstEntryMap = res.first.toColumnMap();

    final room = RoomDB.validatedFromMap(firstEntryMap);

    return room;
  }

  /// Throws [FormatException] if the database schema is invalid.
  @override
  @Throws(
    [
      DatabaseException,
      DBEemptyResult,
    ],
  )
  Future<RoomDB> getRoomByCode(String code) async {
    try {
      final res = await _db.execute(
        Sql.named('SELECT * FROM rooms WHERE code = @code;'),
        parameters: {'code': code},
      );

      res.assertNotEmpty();

      final firstEntryMap = res.first.toColumnMap();

      final room = RoomDB.validatedFromMap(firstEntryMap);

      return room;
    } on DBEemptyResult {
      rethrow;
    } on DatabaseException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<ItemDB>> getRoomItems(String code) async {
    try {
      final roomDb = await getRoomByCode(code);

      final res = await _db.execute(
        Sql.named('SELECT * FROM items WHERE room_id = @id;'),
        parameters: {'id': roomDb.id},
      );

      final items = res.map((entry) {
        final entryMap = entry.toColumnMap();

        final itemDb = ItemDB.validatedFromMap(entryMap);

        if (itemDb == null) {
          throw const FormatException('Invalid database schema');
        }

        return itemDb;
      }).toList();

      return items;
    } on DBEemptyResult {
      rethrow;
    } on DatabaseException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}
