import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/item/implemenations/item_service.dart';
import 'package:shopping_list_backend/item/protocols/item_repository_protocol.dart';
import 'package:shopping_list_backend/item/protocols/item_service_protocol.dart';

ItemServiceProtocol? _itemHandler;

Middleware itemServiceProvider() => provider<Future<ItemServiceProtocol>>(
      (ctx) async => _itemHandler ??= ItemService(
        itemRepository: await ctx.read<Future<ItemRepositoryProtocol>>(),
      ),
    );
