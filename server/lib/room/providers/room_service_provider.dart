import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/room/implementations/room_service.dart';
import 'package:shopping_list_backend/room/protocols/room_repository_protocol.dart';
import 'package:shopping_list_backend/room/protocols/room_service_protocol.dart';

RoomServiceProtocol? _roomHandler;

Middleware roomServiceProvider() => provider<Future<RoomServiceProtocol>>(
      (ctx) async => _roomHandler ??= RoomService(
        roomRepository: await ctx.read<Future<RoomRepositoryProtocol>>(),
      ),
    );
