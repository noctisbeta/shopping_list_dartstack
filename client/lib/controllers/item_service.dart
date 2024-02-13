import 'dart:async';
import 'dart:convert';

import 'package:common/exceptions/bad_map_shape_exception.dart';
import 'package:common/items/create_item_request.dart';
import 'package:common/items/item.dart';
import 'package:common/logger/logger.dart';
import 'package:common/rooms/items/item_message_type.dart';
import 'package:dio/dio.dart';
import 'package:shopping_list/controllers/dio_client.dart';
import 'package:shopping_list/util/web_socket_helper.dart';

final class ItemService extends WebSocketHelper {
  ItemService.connect(String code)
      : super(Uri.parse('ws://localhost:8080/api/v1/rooms/$code/ws'));

  @override
  Future<void> dispose() async {
    await super.dispose();
  }

  Future<void> addItem(CreateItemRequest request) async {
    final local = await channel;

    final json = jsonEncode(request.toMap());

    final map = {
      'type': ItemMessageType.create.encoded,
      'data': json,
    };

    local.sink.add(jsonEncode(map));
  }

  Future<List<Item>> getItems(String code) async {
    LOG.d('Getting shopping list');
    try {
      final response = await dioClient.get('/rooms/$code/items');

      LOG.i('Got response: $response');

      final responseMap = response.data as Map<String, dynamic>;

      final items = switch (responseMap['items']) {
        [
          {
            'id': final int _,
            'name': final String _,
            'quantity': final int _,
            'price': final double _,
            'checked': final bool _,
          },
          ...,
        ] =>
          (responseMap['items'] as List).map(
            (e) {
              e = e as Map<String, dynamic>;
              return Item.validated(
                id: e['id'] as int,
                name: e['name'] as String,
                quantity: e['quantity'] as int,
                price: e['price'] as double,
                checked: e['checked'] as bool,
              );
            },
          ).toList()
            ..sort((a, b) => a.id.compareTo(b.id)),
        _ => null,
      };

      LOG.i('Got items: $items');

      return items ?? [];
    } on DioException catch (e) {
      LOG.e(e.message ?? 'Error getting shopping list');
      return [];
    }
  }

  Stream<List<Item>> itemStream() async* {
    final local = await channel;

    final itemStream = local.stream.map((event) {
      try {
        final list = jsonDecode(event);

        LOG.i('Got items: $list');

        // final items = list.map(Item.validatedFromMap).toList();

        // return items;
        return <Item>[];
      } on FormatException catch (e) {
        LOG.e('Trying to parse Item from event: $e, $event');
        return const <Item>[];
      } on BadMapShapeException catch (e) {
        LOG.e('Trying to instantiate Item from event: $e, $event');
        return const <Item>[];
      }
    });

    yield* itemStream;
  }
}
