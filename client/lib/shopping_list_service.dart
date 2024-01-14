import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/dio_client.dart';
import 'package:shopping_list/shopping_list_item.dart';

abstract final class ShoppingListService {
  static Future<List<ShoppingListItem>> getShoppingList(String code) async {
    log('Getting shopping list for room with code: $code');

    try {
      final response = await dioClient.get('/items/$code');
      log('Got response:${response.data}');

      return (response.data['items'] as List)
          .map((item) => ShoppingListItem(
                name: item['name'] as String,
                quantity: item['quantity'] as int,
                price: item['price'] as double,
              ))
          .toList();
    } on DioException catch (e) {
      log(e.message ?? 'Error getting shopping list');
      debugPrint(e.message ?? 'Error getting shopping list', wrapWidth: 1024);
      return [];
    }
  }

  static Future<ShoppingListItem?> addShoppingListItem(
    ShoppingListItem item,
    String code,
  ) async {
    log('Adding shopping list item: $item');

    try {
      final response = await dioClient.post(
        '/items',
        data: {
          'name': item.name,
          'quantity': item.quantity,
          'price': item.price,
          'code': code,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
      log('Got response:${response.toString()}');
      log('Got response data :${response.data.toString()}');

      return ShoppingListItem(
        name: response.data['item']['name'] as String,
        quantity: response.data['item']['quantity'] as int,
        price: response.data['item']['price'] as double,
      );
    } on DioException catch (e) {
      log(e.message ?? 'Error adding shopping list item');
      debugPrint(e.message ?? 'Error adding shopping list item',
          wrapWidth: 1024);
      return null;
    }
  }
}
