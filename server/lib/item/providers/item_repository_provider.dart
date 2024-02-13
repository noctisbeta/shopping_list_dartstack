import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/item/implemenations/postgres_item_repository.dart';
import 'package:shopping_list_backend/item/interfaces/item_data_source.dart';
import 'package:shopping_list_backend/item/interfaces/item_repository.dart';

ItemRepository? _itemHandler;

Middleware itemRepositoryProvider() => provider<Future<ItemRepository>>(
      (ctx) async => _itemHandler ??= PostgresItemRepository(
        itemDataSource: await ctx.read<Future<ItemDataSource>>(),
      ),
    );
