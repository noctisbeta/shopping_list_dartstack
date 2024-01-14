import 'package:go_router/go_router.dart';
import 'package:shopping_list/entry_view.dart';
import 'package:shopping_list/room_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const EntryView(),
    ),
    GoRoute(
      path: '/room/:code',
      builder: (context, state) => RoomView(
        code: state.pathParameters['code'] as String,
      ),
    ),
  ],
);
