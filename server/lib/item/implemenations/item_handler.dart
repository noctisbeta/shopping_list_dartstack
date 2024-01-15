import 'dart:io';

import 'package:common/item/create_item_request.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/item/protocols/item_handler_protocol.dart';
import 'package:shopping_list_backend/item/protocols/item_service_protocol.dart';

final class ItemHandler implements ItemHandlerProtocol {
  const ItemHandler({
    required this.itemService,
  });

  final ItemServiceProtocol itemService;

  @override
  Future<Response> createItem(RequestContext context) async {
    try {
      final json = await context.request.json();

      final createItemRequest = CreateItemRequest.validatedFromMap(json);

      if (createItemRequest == null) {
        return Response(statusCode: HttpStatus.badRequest);
      }

      final item = await itemService.createItem(createItemRequest);

      return Response.json(
        statusCode: HttpStatus.created,
        body: item.toMap(),
      );
    } on FormatException catch (e) {
      return Response(statusCode: HttpStatus.badRequest, body: e.message);
    } on Exception {
      return Response(statusCode: HttpStatus.internalServerError);
    }
  }

  @override
  Future<Response> getItems(RequestContext context, String code) async {
    try {
      final items = await itemService.getItems(code);

      stdout.writeln(items);

      return Response.json(
        body: items.map((item) => item.toMap()).toList(),
      );
    } on FormatException catch (e) {
      return Response(statusCode: HttpStatus.badRequest, body: e.message);
    } on Exception {
      return Response(statusCode: HttpStatus.internalServerError);
    }
  }
}