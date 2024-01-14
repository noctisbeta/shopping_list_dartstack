import 'package:dart_frog/dart_frog.dart';

import '../../src/room/providers/room_handler_provider.dart';
import '../../src/room/providers/room_repository_provider.dart';
import '../../src/room/providers/room_service_provider.dart';

Handler middleware(Handler handler) {
  return handler
      .use(roomHandlerProvider())
      .use(roomServiceProvider())
      .use(roomRepositoryProvider());
}
