import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/room/protocols/room_handler_protocol.dart';

Future<Response> onRequest(RequestContext context, String code) async {
  stdout.writeln('room/code code: $code');
  final roomHandler = await context.read<Future<RoomHandlerProtocol>>();

  return switch (context.request.method) {
    HttpMethod.get => await roomHandler.getRoomByCode(code),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}
