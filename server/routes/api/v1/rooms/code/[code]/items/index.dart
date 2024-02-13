import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/room/implementations/room_handler.dart';

Future<Response> onRequest(RequestContext context, String code) async {
  final roomHandler = await context.read<Future<RoomHandler>>();

  return switch (context.request.method) {
    HttpMethod.get => await roomHandler.getRoomItems(context, code),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}
