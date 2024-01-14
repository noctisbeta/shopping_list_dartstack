import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../src/room/protocols/room_handler_protocol.dart';

Future<Response> onRequest(RequestContext context, String code) async {
  final roomHandler = context.read<RoomHandlerProtocol>();

  return switch (context.request.method) {
    HttpMethod.get => await roomHandler.getRoomByCode(code),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}
