import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/implementations/postgres_service.dart';
import 'package:shopping_list_backend/item/implemenations/postgres_item_data_source.dart';
import 'package:shopping_list_backend/item/interfaces/item_data_source.dart';

ItemDataSource? _itemHandler;

Middleware itemDataSourceProvider() => provider<Future<ItemDataSource>>(
      (ctx) async => _itemHandler ??= PostgresItemDataSource(
        database: await ctx.read<Future<PostgresService>>(),
      ),
    );
