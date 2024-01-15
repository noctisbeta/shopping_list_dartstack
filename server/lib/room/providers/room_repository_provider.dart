import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/protocols/database_protocol.dart';
import 'package:shopping_list_backend/room/implementations/room_repository.dart';
import 'package:shopping_list_backend/room/protocols/room_repository_protocol.dart';

RoomRepositoryProtocol? _roomsRepository;

Middleware roomRepositoryProvider() => provider<Future<RoomRepositoryProtocol>>(
      (ctx) async => _roomsRepository ??= RoomRepository(
        database: await ctx.read<Future<DatabaseProtocol>>(),
      ),
    );
