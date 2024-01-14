import 'package:dart_frog/dart_frog.dart';

abstract interface class ItemHandlerProtocol {
  Future<Response> createItem(RequestContext context);
  Future<Response> getItems(RequestContext context);
}