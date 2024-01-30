import 'dart:io';

import 'package:common/exceptions/bad_content_type_exception.dart';
import 'package:common/exceptions/bad_request_body_exception.dart';
import 'package:common/logger/logger.dart';
import 'package:common/room/create_room_request.dart';
import 'package:common/room/create_room_response.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/exceptions/database_exception.dart';
import 'package:shopping_list_backend/common/util/request_extension.dart';
import 'package:shopping_list_backend/room/protocols/room_handler_protocol.dart';
import 'package:shopping_list_backend/room/protocols/room_service_protocol.dart';

final class RoomHandler implements RoomHandlerProtocol {
  const RoomHandler({
    required RoomServiceProtocol roomService,
  }) : _roomService = roomService;

  final RoomServiceProtocol _roomService;

  Response _handledDatabaseException(DatabaseException e) {
    switch (e) {
      case DatabaseUnknownException():
        LOG.e('Unknown Database Exception: ${e.message}');
        return Response(
          statusCode: HttpStatus.internalServerError,
          body: 'Unknown Database Exception: ${e.message}',
        );
      case DatabaseUniqueViolationException():
        return Response(
          statusCode: HttpStatus.conflict,
          body: e.message,
        );
      case DatabaseBadCertificateException():
        return Response(
          statusCode: HttpStatus.internalServerError,
          body: e.message,
        );
      case DatabaseSchemaException():
        return Response(
          statusCode: HttpStatus.internalServerError,
          body: e.message,
        );
      case DatabaseEmptyResultException():
        return Response(
          statusCode: HttpStatus.notFound,
          body: e.message,
        );
    }
  }

  @override
  Future<Response> createRoom(RequestContext context) async {
    try {
      final request = context.request
        ..assertContentType(ContentType.json.mimeType);

      final json = await request.json();

      final createRoomRequest = CreateRoomRequest.validatedFromMap(json);

      final room = await _roomService.createRoom(createRoomRequest);

      final createRoomResponse = CreateRoomResponse(room: room);

      return Response.json(
        statusCode: HttpStatus.created,
        body: createRoomResponse.toMap(),
      );
    } on BadContentTypeException catch (e) {
      return Response(
        statusCode: HttpStatus.unsupportedMediaType,
        body: e.message,
      );
    } on FormatException catch (e) {
      return Response(
        statusCode: HttpStatus.badRequest,
        body: e.message,
      );
    } on BadRequestBodyException catch (e) {
      return Response(
        statusCode: HttpStatus.badRequest,
        body: e.message,
      );
    } on DatabaseException catch (e) {
      return _handledDatabaseException(e);
    } on Exception catch (e) {
      LOG.e('Unexpected exception of type ${e.runtimeType}: $e');
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: 'Unexpected exception: $e',
      );
    }
  }

  @override
  Future<Response> getRoomByCode(RequestContext context, String code) async {
    try {
      final room = await _roomService.getRoomByCode(code);

      return Response.json(
        body: room.toMap(),
      );
    } on DatabaseException catch (e) {
      switch (e) {
        case DatabaseUnknownException():
          LOG.e('Unknown Database Exception: ${e.message}');
          return Response(
            statusCode: HttpStatus.internalServerError,
            body: 'Unknown Database Exception: ${e.message}',
          );
        case DatabaseUniqueViolationException():
          return Response(
            statusCode: HttpStatus.conflict,
            body: e.message,
          );

        case DatabaseBadCertificateException():
          return Response(
            statusCode: HttpStatus.internalServerError,
            body: e.message,
          );
        case DatabaseSchemaException():
          return Response(
            statusCode: HttpStatus.internalServerError,
            body: e.message,
          );
        case DatabaseEmptyResultException():
          return Response(
            statusCode: HttpStatus.notFound,
            body: e.message,
          );
      }
    } on FormatException catch (e) {
      return Response(statusCode: HttpStatus.badRequest, body: e.message);
    } on Exception {
      return Response(statusCode: HttpStatus.internalServerError);
    }
  }

  @override
  Future<Response> getRoomItems(RequestContext context, String code) async {
    try {
      final items = await _roomService.getRoomItems(code);

      stdout.writeln(items);

      return Response.json(
        body: {
          'items': items.map((item) => item.toMap()).toList(),
        },
      );
    } on FormatException catch (e) {
      return Response(statusCode: HttpStatus.badRequest, body: e.message);
    } on Exception {
      return Response(statusCode: HttpStatus.internalServerError);
    }
  }
}
