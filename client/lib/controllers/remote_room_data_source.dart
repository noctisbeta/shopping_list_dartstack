import 'dart:io';

import 'package:common/exceptions/response_exception.dart';
import 'package:common/logger/logger.dart';
import 'package:common/rooms/create_room_request.dart';
import 'package:common/rooms/create_room_response.dart';
import 'package:common/rooms/get_room_request.dart';
import 'package:common/rooms/get_room_response.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shopping_list/controllers/dio_wrapper.dart';
import 'package:shopping_list/exceptions/backend_exception.dart';
import 'package:shopping_list/exceptions/room_exception.dart';
import 'package:shopping_list/interfaces/room_data_source.dart';

@immutable
final class RemoteRoomDataSource implements RoomDataSource {
  const RemoteRoomDataSource({required DioWrapper dio}) : _diow = dio;

  final DioWrapper _diow;

  static const _roomsPath = '/rooms';

  @override
  Future<CreateRoomResponse> createRoom(CreateRoomRequest request) async {
    try {
      final dioResponse = await _diow.post(
        _roomsPath,
        data: request,
      );

      LOG.d(dioResponse.data);

      final domainResponse = CreateRoomResponse.validatedFromMap(
        dioResponse.data,
      );

      return domainResponse;
    } on DioException catch (e) {
      LOG.e(e.response?.data ?? 'Error creating room $e');
      final code = e.response?.statusCode;

      switch (code) {
        case HttpStatus.conflict:
          LOG.i('Room already exists');
          throw REalreadyExists(
            'Room with access code ${request.code} already exists',
          );
        default:
          LOG.e('Unknown error creating room');
          rethrow;
      }
    } on Exception catch (e) {
      LOG.e('Unknown exception $e');
      rethrow;
    }
  }

  @override
  Future<GetRoomResponse> getRoomByCode(GetRoomRequest request) async {
    try {
      final dioResponse = await _diow.get(
        '$_roomsPath/code/${request.code}',
      );

      LOG.d(dioResponse.data);

      final responseData = dioResponse.data as Map<String, dynamic>;

      final domainResponse = GetRoomResponse.validatedFromMap(
        responseData,
      );

      return domainResponse;
    } on DioException catch (e) {
      final code = e.response?.statusCode;

      switch (code) {
        case HttpStatus.notFound:
          LOG.i('Room not found');
          throw REnotFound(
            'Room with access code ${request.code} not found.',
          );

        case null:
          LOG.e('No status code while getting room');
          rethrow;

        default:
          LOG.e('Unknown status code while getting room');
          rethrow;
      }
    } on BadResponseBodyException catch (e) {
      LOG.e(e.message);
      throw BEinvalidResponse(e.message);
    } on Exception catch (e) {
      LOG.e('Unknown exception $e');
      rethrow;
    }
  }
}
