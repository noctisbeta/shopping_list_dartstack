import 'package:common/item/check_item_request.dart';
import 'package:common/item/create_item_request.dart';
import 'package:common/item/item.dart';

abstract interface class ItemServiceProtocol {
  Future<Item> createItem(CreateItemRequest request);
  Future<List<Item>> getItems(String code);
  Future<Item> checkItem(CheckItemRequest request, int id);
}
