import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/item/implemenations/item_handler.dart';
import 'package:shopping_list_backend/item/interfaces/item_repository.dart';

ItemHandler? _itemHandler;

Middleware itemHandlerProvider() => provider<Future<ItemHandler>>(
      (ctx) async => _itemHandler ??= ItemHandler(
        itemService: await ctx.read<Future<ItemRepository>>(),
      ),
    );
