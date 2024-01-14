import 'package:dart_frog/dart_frog.dart';

abstract interface class ItemRepositoryProtocol {
  Future<Response> createItem(RequestContext context);
  Future<Response> getItems(RequestContext context);
}
