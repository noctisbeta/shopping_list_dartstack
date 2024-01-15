import 'package:common/room/create_room_request.dart';
import 'package:postgres/postgres.dart';
import 'package:shopping_list_backend/common/protocols/database_protocol.dart';
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
    final res = await conn.execute(
      Sql.named('INSERT INTO rooms (code) VALUES (@code) RETURNING id;'),
      parameters: {'code': request.code},
    );

    final firstEntryMap = res.first.toColumnMap();

    final room = switch (firstEntryMap) {
      <String, dynamic>{
        'id': final int _,
        'code': final String _,
      } =>
        RoomDB.fromMap(firstEntryMap),
      _ => throw const FormatException('Invalid database schema'),
    };

    return room;
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

      final room = switch (firstEntryMap) {
        <String, dynamic>{
          'id': final int _,
          'code': final String _,
        } =>
          RoomDB.fromMap(firstEntryMap),
        _ => throw const FormatException('Invalid database schema'),
      };

      return room;
    } on Exception {
      rethrow;
    }
  }

  @override
  void getRoomById(int id) {}
}
