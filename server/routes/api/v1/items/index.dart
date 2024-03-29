import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/item/implemenations/item_handler.dart';

Future<Response> onRequest(RequestContext context) async {
  final itemHandler = await context.read<Future<ItemHandler>>();

  return switch (context.request.method) {
    HttpMethod.post => await itemHandler.createItem(context),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}
