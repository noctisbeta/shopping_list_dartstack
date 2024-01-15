import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/protocols/database_protocol.dart';
import 'package:shopping_list_backend/item/implemenations/item_repository.dart';
import 'package:shopping_list_backend/item/protocols/item_repository_protocol.dart';

ItemRepositoryProtocol? _itemHandler;

Middleware itemRepositoryProvider() => provider<Future<ItemRepositoryProtocol>>(
      (ctx) async => _itemHandler ??= ItemRepository(
        database: await ctx.read<Future<DatabaseProtocol>>(),
      ),
    );
