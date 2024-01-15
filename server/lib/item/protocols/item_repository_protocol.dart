import 'package:common/item/create_item_request.dart';
import 'package:shopping_list_backend/item/models/item_db.dart';

abstract interface class ItemRepositoryProtocol {
  Future<ItemDB> createItem(CreateItemRequest request);
  Future<List<ItemDB>> getItems(String code);
}
