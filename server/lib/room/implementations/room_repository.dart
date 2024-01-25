import 'package:common/room/create_room_request.dart';
import 'package:postgres/postgres.dart';
import 'package:shopping_list_backend/common/exceptions/database_exception.dart';
import 'package:shopping_list_backend/common/protocols/database_protocol.dart';
import 'package:shopping_list_backend/item/models/item_db.dart';
import 'package:shopping_list_backend/room/models/room_db.dart';
import 'package:shopping_list_backend/room/protocols/room_repository_protocol.dart';

final class RoomRepository implements RoomRepositoryProtocol {
  const RoomRepository({
    required DatabaseProtocol database,
  }) : _database = database;

  final DatabaseProtocol _database;

  Connection get conn => _database.connection;

  @override
  Future<RoomDB> createRoom(CreateRoomRequest request) async {
    try {
      final res = await conn.execute(
        Sql.named('INSERT INTO rooms (code) VALUES (@code) RETURNING *;'),
        parameters: {'code': request.code},
      );

      final firstEntryMap = res.first.toColumnMap();

      final room = RoomDB.validatedFromMap(firstEntryMap);

      return room;
    } on ServerException catch (e) {
      switch (e.code) {
        case '23505':
          throw DatabaseUniqueViolationException(e.toString());
        default:
          throw DatabaseUnknownException(e.toString());
      }
    } on BadCertificateException catch (e) {
      throw DatabaseBadCertificateException(e.toString());
    } on Exception {
      rethrow;
    }
  }

  /// Throws [FormatException] if the database schema is invalid.
  @override
  Future<RoomDB> getRoomByCode(String code) async {
    try {
      final res = await conn.execute(
        Sql.named('SELECT * FROM rooms WHERE code = @code;'),
        parameters: {'code': code},
      );

      final firstEntryMap = res.first.toColumnMap();

      final room = RoomDB.validatedFromMap(firstEntryMap);

      return room;
    } on Exception {
      rethrow;
    }
  }

  @override
  void getRoomById(int id) {}

  @override
  Future<List<ItemDB>> getRoomItems(String code) async {
    try {
      final room = await getRoomByCode(code);

      final res = await conn.execute(
        Sql.named('SELECT * FROM items WHERE room_id = @id;'),
        parameters: {'id': room.id},
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
    } on Exception {
      rethrow;
    }
  }
}
