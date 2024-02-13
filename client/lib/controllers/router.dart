import 'package:go_router/go_router.dart';
import 'package:shopping_list/controllers/item_service.dart';
import 'package:shopping_list/views/entry_view.dart';
import 'package:shopping_list/views/room_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const EntryView(),
    ),
    GoRoute(
      path: '/room/:code',
      builder: (context, state) => switch (state.pathParameters['code']) {
        final String code => RoomView(
            code: code,
            itemService: ItemService.connect(code),
          ),
        null => throw Error(),
      },
    ),
  ],
);
