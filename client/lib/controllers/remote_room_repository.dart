import 'package:common/exceptions/request_Exception.dart';
import 'package:common/rooms/create_room_request.dart';
import 'package:common/rooms/get_room_request.dart';
import 'package:common/rooms/room.dart';
import 'package:shopping_list/exceptions/room_exception.dart';
import 'package:shopping_list/interfaces/room_data_source.dart';
import 'package:shopping_list/interfaces/room_repository_protocol.dart';

final class RemoteRoomRepository implements RoomRepository {
  const RemoteRoomRepository({required RoomDataSource dataSource})
      : _dataSource = dataSource;

  final RoomDataSource _dataSource;

  @override
  Future<Room> createRoom(String code) async {
    final request = CreateRoomRequest.validated(code: code);
    final response = await _dataSource.createRoom(request);
    return response.room;
  }

  @override
  Future<Room> getRoomByCode(String code) async {
    try {
      final request = GetRoomRequest.validated(code: code);
      final response = await _dataSource.getRoomByCode(request);
      return response.room;
    } on BadRequestBodyException catch (e) {
      throw REinvalidCode('Invalid code $e');
    }
  }
}
