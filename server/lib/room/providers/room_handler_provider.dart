import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/room/implementations/room_handler.dart';
import 'package:shopping_list_backend/room/interfaces/room_repository.dart';

RoomHandler? _roomHandler;

Middleware roomHandlerProvider() => provider<Future<RoomHandler>>(
      (ctx) async => _roomHandler ??= RoomHandler(
        roomRepository: await ctx.read<Future<RoomRepository>>(),
      ),
    );
