import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/room/implementations/postgres_room_repository.dart';
import 'package:shopping_list_backend/room/interfaces/room_data_source.dart';
import 'package:shopping_list_backend/room/interfaces/room_repository.dart';

RoomRepository? _roomHandler;

Middleware roomServiceProvider() => provider<Future<RoomRepository>>(
      (ctx) async => _roomHandler ??= PostgresRoomRepository(
        roomDataSource: await ctx.read<Future<RoomDataSource>>(),
      ),
    );
