import 'dart:convert';

import 'package:common/items/create_item_request.dart';
import 'package:common/logger/logger.dart';
import 'package:common/rooms/items/item_message_type.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:shopping_list_backend/item/implemenations/item_socket_handler.dart';
import 'package:shopping_list_backend/item/interfaces/item_repository.dart';

Future<Response> onRequest(RequestContext context, String code) async {
  final itemSocketHandler = await context.read<Future<ItemSocketHandler>>();

  final itemService = await context.read<Future<ItemRepository>>();

  final handler = webSocketHandler((channel, protocol) async {
    channel.stream.listen((message) async {
      LOG.i('websocket msg: $message');

      final json = jsonDecode(
        message,
        reviver: (key, value) {
          if (key == 'data' && value is String) {
            return jsonDecode(value);
          }
          return value;
        },
      );

      LOG.i('Decoded json: $json');
      LOG.i('Type: ${json['data'].runtimeType}');

      switch (json) {
        case {
            'type': final String type,
            'data': final Map<String, dynamic> data,
          }:
          LOG.i('Here with data: $data');

          final messageType = ItemMessageType.values
              .where((e) => e.encoded == type)
              .firstOrNull;

          switch (messageType) {
            case ItemMessageType.create:
              final request = CreateItemRequest.validatedFromMap(data);
              // final item = await itemSocketHandler.createItem(request);

              final item = await itemService.createItem(request);

              LOG.i('Adding item to channel: ${item.toMap()}');

              channel.sink.add(jsonEncode(item.toMap()));
            case null:
              channel.sink.add('Unsupported message type $type');
          }
        default:
          LOG.w('Unsupported message: $json');
      }
    });
  });
  return handler(context);
}
