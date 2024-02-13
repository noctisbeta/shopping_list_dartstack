import 'package:common/items/check_item_request.dart';
import 'package:common/items/create_item_request.dart';
import 'package:shopping_list_backend/item/models/item_db.dart';

abstract interface class ItemDataSource {
  Future<ItemDB> createItem(CreateItemRequest request);
  Future<List<ItemDB>> getItems(String code);
  Future<ItemDB> checkItem(CheckItemRequest request, int id);
}
