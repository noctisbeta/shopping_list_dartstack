import 'package:common/item/create_item_request.dart';
import 'package:dart_frog/dart_frog.dart';

abstract interface class ItemServiceProtocol {
  Future<Item> createItem(CreateItemRequest request);
  Future<Response> getItems(RequestContext context);
}
