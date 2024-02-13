import 'dart:io';

import 'package:common/items/check_item_request.dart';
import 'package:common/items/create_item_request.dart';
import 'package:common/items/item.dart';
import 'package:shopping_list_backend/item/interfaces/item_data_source.dart';
import 'package:shopping_list_backend/item/interfaces/item_repository.dart';

final class PostgresItemRepository implements ItemRepository {
  const PostgresItemRepository({required ItemDataSource itemDataSource})
      : _itemDataSource = itemDataSource;

  final ItemDataSource _itemDataSource;

  @override
  Future<Item> createItem(CreateItemRequest request) async {
    try {
      final itemDb = await _itemDataSource.createItem(request);

      return Item.validated(
        id: itemDb.id,
        name: itemDb.name,
        price: itemDb.price,
        quantity: itemDb.quantity,
        checked: itemDb.checked,
      );
    } on FormatException {
      rethrow;
    }
  }

  @override
  Future<List<Item>> getItems(String code) async {
    try {
      final res = await _itemDataSource.getItems(code);

      final items = res
          .map(
            (itemDb) => Item.validated(
              id: itemDb.id,
              name: itemDb.name,
              price: itemDb.price,
              quantity: itemDb.quantity,
              checked: itemDb.checked,
            ),
          )
          .toList()
        ..sort((a, b) => a.id.compareTo(b.id));

      stdout.writeln(items);

      return items;
    } on FormatException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Item> checkItem(CheckItemRequest request, int id) async {
    try {
      final item = await _itemDataSource.checkItem(request, id);

      return Item.validated(
        id: item.id,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        checked: item.checked,
      );
    } on FormatException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}
