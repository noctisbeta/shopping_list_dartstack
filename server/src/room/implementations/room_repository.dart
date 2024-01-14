import 'package:common/room/create_room_request.dart';
import 'package:postgres/postgres.dart';

import '../../common/protocols/database_protocol.dart';
import '../models/room_db.dart';
import '../protocols/room_repository_protocol.dart';

final class RoomRepository implements RoomRepositoryProtocol {
  RoomRepository({
    required Future<DatabaseProtocol> database,
  }) : _databaseFuture = database;

  final Future<DatabaseProtocol> _databaseFuture;

  Future<Connection> getConnection() async {
    return (await _databaseFuture).connection;
  }

  @override
  Future<void> createRoom(CreateRoomRequest request) async {
    final conn = await getConnection();
    await conn.execute(
      Sql.named('INSERT INTO rooms (code) VALUES (@code) RETURNING id;'),
      parameters: {'code': request.code},
    );
  }

  @override
  Future<RoomDB> getRoomByCode(String code) async {
    try {
      final conn = await getConnection();
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
    } catch (e) {
      rethrow;
    }
  }

  @override
  void getRoomById(int id) {}
}
