import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/implementations/postgres_service.dart';
import 'package:shopping_list_backend/room/implementations/postgres_room_data_source.dart';
import 'package:shopping_list_backend/room/interfaces/room_data_source.dart';

RoomDataSource? _roomDataSource;

Middleware roomDataSourceProvider() => provider<Future<RoomDataSource>>(
      (ctx) async => _roomDataSource ??= PostgresRoomDataSource(
        database: await ctx.read<Future<PostgresService>>(),
      ),
    );
