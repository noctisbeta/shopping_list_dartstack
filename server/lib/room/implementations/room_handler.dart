import 'dart:io';

import 'package:common/room/create_room_request.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/room/protocols/room_handler_protocol.dart';
import 'package:shopping_list_backend/room/protocols/room_service_protocol.dart';

final class RoomHandler implements RoomHandlerProtocol {
  const RoomHandler({
    required RoomServiceProtocol roomService,
  }) : _roomService = roomService;

  final RoomServiceProtocol _roomService;

  @override
  Future<Response> createRoom(RequestContext context) async {
    try {
      final json = await context.request.json();

      final createRoomRequest = CreateRoomRequest.validatedFromMap(json);

      if (createRoomRequest == null) {
        return Response(statusCode: HttpStatus.badRequest);
      }

      final room = await _roomService.createRoom(createRoomRequest);

      return Response.json(
        statusCode: HttpStatus.created,
        body: room.toMap(),
      );
    } on FormatException catch (e) {
      return Response(statusCode: HttpStatus.badRequest, body: e.message);
    } on Exception {
      return Response(statusCode: HttpStatus.internalServerError);
    }
  }

  @override
  Future<Response> getRoomByCode(String code) async {
    try {
      final room = await _roomService.getRoomByCode(code);

      return Response.json(
        body: room.toMap(),
      );
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
