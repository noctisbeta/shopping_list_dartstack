import 'package:dart_frog/dart_frog.dart';

import '../implementations/room_handler.dart';
import '../protocols/room_handler_protocol.dart';
import '../protocols/room_service_protocol.dart';

RoomHandlerProtocol? _roomHandler;

Middleware roomHandlerProvider() {
  return provider<RoomHandlerProtocol>(
    (ctx) => _roomHandler ??= RoomHandler(
      roomService: ctx.read<RoomServiceProtocol>(),
    ),
  );
}
