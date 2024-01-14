import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping_list/dio_client.dart';

abstract final class RoomService {
  static Future<String?> getRoomByCode(String code) async {
    try {
      final response = await dioClient.get('/room/$code');
      log('Got response:${response.data}');

      return response.data['code'] as String;
    } on DioException catch (e) {
      log(e.message ?? 'Error getting room by code');
      return null;
    }
  }

  static Future<String?> createRoom(String code) async {
    try {
      final response = await dioClient.post(
        '/room',
        data: {'code': code},
        options: Options(contentType: Headers.jsonContentType),
      );
      log('Got response:${response.data}');

      return response.data['code'] as String;
    } on DioException catch (e) {
      log(e.message ?? 'Error creating room');
      return null;
    }
  }
}
