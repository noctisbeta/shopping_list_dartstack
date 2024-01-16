import 'dart:developer';

import 'package:common/room/create_room_request.dart';
import 'package:common/room/room.dart';
import 'package:dio/dio.dart';
import 'package:shopping_list/dio_client.dart';

abstract final class RoomService {
  final todo = '';

  static Future<Room?> getRoomByCode(String code) async {
    try {
      final response = await dioClient.get('/rooms/$code');

      final room = Room.validatedFromMap(response.data);

      return room;
    } on DioException catch (e) {
      log(e.message ?? 'Error getting room by code');
      return null;
    }
  }

  static Future<Room?> createRoom(String code) async {
    try {
      final createRoomRequest = CreateRoomRequest(code: code);

      final response = await dioClient.post(
        '/rooms',
        data: createRoomRequest.toMap(),
        options: Options(contentType: Headers.jsonContentType),
      );

      final room = Room.validatedFromMap(response.data);

      return room;
    } on DioException catch (e) {
      log(e.message ?? 'Error creating room');
      return null;
    }
  }
}
