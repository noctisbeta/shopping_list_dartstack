import 'package:common/items/check_item_request.dart';
import 'package:common/items/create_item_request.dart';
import 'package:common/items/item.dart';

abstract interface class ItemRepository {
  Future<Item> createItem(CreateItemRequest request);
  Future<List<Item>> getItems(String code);
  Future<Item> checkItem(CheckItemRequest request, int id);
}
