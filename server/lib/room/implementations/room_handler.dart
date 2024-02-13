import 'dart:io';

import 'package:common/exceptions/request_exception.dart';
import 'package:common/logger/logger.dart';
import 'package:common/rooms/create_room_request.dart';
import 'package:common/rooms/create_room_response.dart';
import 'package:common/rooms/get_room_response.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/exceptions/database_exception.dart';
import 'package:shopping_list_backend/common/util/request_extension.dart';
import 'package:shopping_list_backend/room/interfaces/room_repository.dart';

final class RoomHandler {
  const RoomHandler({
    required RoomRepository roomRepository,
  }) : _roomService = roomRepository;

  final RoomRepository _roomService;

  Response _handledUnknownException(Exception e) {
    LOG.e('Unknown Exception: ${e.runtimeType}: $e');
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: 'Unknown Exception: ${e.runtimeType}: $e',
    );
  }

  Response _handledRequestException(RequestException e) {
    switch (e) {
      case BadRequestContentTypeException():
        return Response(
          statusCode: HttpStatus.unsupportedMediaType,
          body: e.message,
        );
      case BadRequestBodyException():
        return Response(
          statusCode: HttpStatus.badRequest,
          body: e.message,
        );
    }
  }

  Response _handledDatabaseException(DatabaseException e) {
    switch (e) {
      case DBEunknown():
        LOG.e('Unknown Database Exception: ${e.message}');
        return Response(
          statusCode: HttpStatus.internalServerError,
          body: 'Unknown Database Exception: ${e.message}',
        );
      case DBEuniqueViolation():
        return Response(
          statusCode: HttpStatus.conflict,
          body: e.message,
        );
      case DBEbadCertificate():
        return Response(
          statusCode: HttpStatus.internalServerError,
          body: e.message,
        );
      case DBEbadSchema():
        return Response(
          statusCode: HttpStatus.internalServerError,
          body: e.message,
        );
      case DBEemptyResult():
        return Response(
          statusCode: HttpStatus.notFound,
          body: e.message,
        );
    }
  }

  Future<Response> createRoom(RequestContext context) async {
    try {
      final request = context.request
        ..assertContentType(ContentType.json.mimeType);

      final json = await request.json();

      final createRoomRequest = CreateRoomRequest.validatedFromMap(json);

      final room = await _roomService.createRoom(createRoomRequest);

      final createRoomResponse = CreateRoomResponse.validated(room: room);

      return Response.json(
        statusCode: HttpStatus.created,
        body: createRoomResponse.toMap(),
      );
    } on RequestException catch (e) {
      return _handledRequestException(e);
    } on FormatException catch (e) {
      return Response(statusCode: HttpStatus.badRequest, body: e.message);
    } on DatabaseException catch (e) {
      return _handledDatabaseException(e);
    } on Exception catch (e) {
      return _handledUnknownException(e);
    }
  }

  Future<Response> getRoomByCode(RequestContext context, String code) async {
    try {
      final room = await _roomService.getRoomByCode(code);

      final roomMap = {
        'room': room.toMap(),
      };

      final getRoomResponse = GetRoomResponse.validatedFromMap(roomMap);

      return Response.json(
        body: getRoomResponse.toMap(),
      );
    } on DatabaseException catch (e) {
      return _handledDatabaseException(e);
    } on FormatException catch (e) {
      return Response(statusCode: HttpStatus.badRequest, body: e.message);
    } on Exception catch (e) {
      return _handledUnknownException(e);
    }
  }

  Future<Response> getRoomItems(RequestContext context, String code) async {
    try {
      final items = await _roomService.getRoomItems(code);

      return Response.json(
        body: {
          'items': items.map((item) => item.toMap()).toList(),
        },
      );
    } on DatabaseException catch (e) {
      return _handledDatabaseException(e);
    } on FormatException catch (e) {
      return Response(statusCode: HttpStatus.badRequest, body: e.message);
    } on Exception catch (e) {
      return _handledUnknownException(e);
    }
  }
}
