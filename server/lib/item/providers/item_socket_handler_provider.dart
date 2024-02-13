import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/item/implemenations/item_socket_handler.dart';

ItemSocketHandler? _itemSocketHandler;

Middleware itemSocketHandlerProvider() => provider<Future<ItemSocketHandler>>(
      (ctx) async => _itemSocketHandler ??= const ItemSocketHandler(),
    );
