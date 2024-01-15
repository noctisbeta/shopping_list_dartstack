import 'dart:developer';

import 'package:common/item/create_item_request.dart';
import 'package:common/item/item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/dio_client.dart';

abstract final class ShoppingListService {
  final todo = '';

  static Future<List<Item>> getShoppingList(String code) async {
    log('Getting shopping list');
    try {
      final response = await dioClient.get('/item/$code');

      log('Got response: $response');

      final items = switch (response.data) {
        [
          {
            'name': final String _,
            'quantity': final int _,
            'price': final double _
          },
          ...,
        ] =>
          (response.data as List).map(
            (e) {
              e = e as Map<String, dynamic>;
              return Item(
                name: e['name'] as String,
                quantity: e['quantity'] as int,
                price: e['price'] as double,
              );
            },
          ).toList(),
        _ => null,
      };

      log('Got items: $items');

      return items ?? [];
    } on DioException catch (e) {
      log(e.message ?? 'Error getting shopping list');
      debugPrint(e.message ?? 'Error getting shopping list', wrapWidth: 1024);
      return [];
    }
  }

  static Future<Item?> addShoppingListItem(
    Item item,
    String code,
  ) async {
    log('Adding shopping list item: $item');

    try {
      final response = await dioClient.post(
        '/item',
        data: CreateItemRequest(
          name: item.name,
          price: item.price,
          quantity: item.quantity,
          roomCode: code,
        ).toMap(),
        options: Options(contentType: Headers.jsonContentType),
      );
      log('Got response: $response');
      log('Got response data: ${response.data}');

      final itemRes = switch (response.data) {
        {
          'name': final String name,
          'quantity': final int quantity,
          'price': final double price,
        } =>
          Item(
            name: name,
            quantity: quantity,
            price: price,
          ),
        _ => null,
      };

      return itemRes;
    } on DioException catch (e) {
      log(e.message ?? 'Error adding shopping list item');
      debugPrint(
        e.message ?? 'Error adding shopping list item',
        wrapWidth: 1024,
      );
      return null;
    }
  }
}
