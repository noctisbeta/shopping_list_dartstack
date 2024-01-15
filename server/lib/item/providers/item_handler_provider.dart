import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/item/implemenations/item_handler.dart';
import 'package:shopping_list_backend/item/protocols/item_handler_protocol.dart';
import 'package:shopping_list_backend/item/protocols/item_service_protocol.dart';

ItemHandlerProtocol? _itemHandler;

Middleware itemHandlerProvider() => provider<Future<ItemHandlerProtocol>>(
      (ctx) async => _itemHandler ??= ItemHandler(
        itemService: await ctx.read<Future<ItemServiceProtocol>>(),
      ),
    );
