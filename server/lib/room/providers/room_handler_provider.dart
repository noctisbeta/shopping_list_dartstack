import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/room/implementations/room_handler.dart';
import 'package:shopping_list_backend/room/protocols/room_handler_protocol.dart';
import 'package:shopping_list_backend/room/protocols/room_service_protocol.dart';

RoomHandlerProtocol? _roomHandler;

Middleware roomHandlerProvider() => provider<Future<RoomHandlerProtocol>>(
      (ctx) async => _roomHandler ??= RoomHandler(
        roomService: await ctx.read<Future<RoomServiceProtocol>>(),
      ),
    );
