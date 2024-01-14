import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method) {
    HttpMethod.post => await itemHandler.createItem(context),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}
