import 'dart:io';

import 'package:common/item/check_item_request.dart';
import 'package:common/item/create_item_request.dart';
import 'package:common/item/item.dart';
import 'package:shopping_list_backend/item/protocols/item_repository_protocol.dart';
import 'package:shopping_list_backend/item/protocols/item_service_protocol.dart';

final class ItemService implements ItemServiceProtocol {
  const ItemService({required this.itemRepository});

  final ItemRepositoryProtocol itemRepository;

  @override
  Future<Item> createItem(CreateItemRequest request) async {
    try {
      final item = await itemRepository.createItem(request);

      return Item(
        id: item.id,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
      );
    } on FormatException {
      rethrow;
    }
  }

  @override
  Future<List<Item>> getItems(String code) async {
    try {
      final res = await itemRepository.getItems(code);

      final items = res
          .map(
            (itemDb) => Item(
              id: itemDb.id,
              name: itemDb.name,
              price: itemDb.price,
              quantity: itemDb.quantity,
            ),
          )
          .toList();

      stdout.writeln(items);

      return items;
    } on FormatException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Item> checkItem(CheckItemRequest request) async {
    try {
      final item = await itemRepository.checkItem(request);

      return Item(
        id: item.id,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
      );
    } on FormatException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}
