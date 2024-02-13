import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/room/providers/room_handler_provider.dart';
import 'package:shopping_list_backend/room/providers/room_repository_provider.dart';
import 'package:shopping_list_backend/room/providers/room_service_provider.dart';

Handler middleware(Handler handler) => handler
    .use(roomHandlerProvider())
    .use(roomServiceProvider())
    .use(roomDataSourceProvider());
