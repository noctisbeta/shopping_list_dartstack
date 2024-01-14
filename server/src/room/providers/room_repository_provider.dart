import 'package:dart_frog/dart_frog.dart';

import '../../common/protocols/database_protocol.dart';
import '../protocols/room_repository_protocol.dart';
import '../implementations/room_repository.dart';

RoomRepositoryProtocol? _roomsRepository;

Middleware roomRepositoryProvider() {
  return provider<RoomRepositoryProtocol>(
    (ctx) => _roomsRepository ??= RoomRepository(
      database: ctx.read<Future<DatabaseProtocol>>(),
    ),
  );
}
