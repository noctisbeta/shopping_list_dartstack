import 'dart:io';

import 'package:common/room/create_room_request.dart';
import 'package:dart_frog/src/_internal.dart';

import '../protocols/room_handler_protocol.dart';
import '../protocols/room_service_protocol.dart';

final class RoomHandler implements RoomHandlerProtocol {
  const RoomHandler({
    required RoomServiceProtocol roomService,
  }) : _roomService = roomService;

  final RoomServiceProtocol _roomService;

  @override
  Future<Response> createRoom(RequestContext context) async {
    try {
      final json = await context.request.json();

      final createRoomRequest = switch (json) {
        <String, dynamic>{'code': final String _} =>
          CreateRoomRequest.fromMap(json),
        _ => throw const FormatException('Invalid JSON'),
      };

      _roomService.createRoom(createRoomRequest);

      return Response(statusCode: HttpStatus.created);
    } on FormatException catch (e) {
      return Response(statusCode: HttpStatus.badRequest, body: e.message);
    } catch (e) {
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
    } catch (e) {
      return Response(statusCode: HttpStatus.internalServerError);
    }
  }
}
