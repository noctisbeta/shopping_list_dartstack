import 'dart:io';

import 'package:common/items/create_item_request.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/util/request_extension.dart';
import 'package:shopping_list_backend/item/interfaces/item_repository.dart';

final class ItemHandler {
  const ItemHandler({
    required this.itemService,
  });

  final ItemRepository itemService;

  Future<Response> createItem(RequestContext context) async {
    try {
      final request = context.request
        ..assertContentType(ContentType.json.mimeType);

      final json = await request.json();

      final createItemRequest = CreateItemRequest.validatedFromMap(json);

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
}
