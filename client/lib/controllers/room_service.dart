import 'dart:io';

import 'package:common/logger/logger.dart';
import 'package:common/rooms/create_room_request.dart';
import 'package:common/rooms/get_room_response.dart';
import 'package:common/rooms/room.dart';
import 'package:dio/dio.dart';
import 'package:shopping_list/controllers/dio_client.dart';
import 'package:shopping_list/exceptions/room_exception.dart';

abstract final class RoomService {
  final todo = '';

  static Future<Room> getRoomByCode(String code) async {
    try {
      final response = await dioClient.get('/rooms/$code');

      final getRoomResponse = GetRoomResponse.validatedFromMap(response.data);

      final room = getRoomResponse.room;

      return room;
    } on DioException catch (e) {
      LOG.e(e.response?.data ?? 'Error creating room $e');
      final code = e.response?.statusCode;

      switch (code) {
        case HttpStatus.notFound:
          LOG.e('Room not found');
          throw REnotFound(
            'Room with access code $code does not exist',
          );
        default:
          LOG.e('Unknown error creating room');
          rethrow;
      }
    }
  }

  static Future<Room?> createRoom(String code) async {
    try {
      final createRoomRequest = CreateRoomRequest.validated(code: code);

      final response = await dioClient.post(
        '/rooms',
        data: createRoomRequest.toMap(),
        options: Options(contentType: Headers.jsonContentType),
      );

      LOG.i(response.data);

      final room = Room.validatedFromMap(
        (response.data as Map<String, dynamic>)['room'],
      );

      return room;
    } on DioException catch (e) {
      LOG.e(e.response?.data ?? 'Error creating room $e');
      final code = e.response?.statusCode;

      switch (code) {
        case HttpStatus.conflict:
          LOG.e('Room already exists');
        default:
          LOG.e('Unknown error creating room');
      }
      return null;
    } on Exception catch (e) {
      LOG.e('Unknown exception $e');
      return null;
    }
  }
}
