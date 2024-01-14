import 'package:dart_frog/dart_frog.dart';

import '../implementations/room_service.dart';
import '../protocols/room_repository_protocol.dart';
import '../protocols/room_service_protocol.dart';

RoomServiceProtocol? _roomHandler;

Middleware roomServiceProvider() {
  return provider<RoomServiceProtocol>(
    (ctx) => _roomHandler ??= RoomService(
      roomRepository: ctx.read<RoomRepositoryProtocol>(),
    ),
  );
}
