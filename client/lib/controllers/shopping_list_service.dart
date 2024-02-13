import 'dart:developer';

import 'package:common/items/create_item_request.dart';
import 'package:common/items/item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/controllers/dio_client.dart';

abstract final class ShoppingListService {
  final todo = '';

  static Future<List<Item>> getShoppingList(String code) async {
    log('Getting shopping list');
    try {
      final response = await dioClient.get('/rooms/$code/items');

      log('Got response: $response');

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

      log('Got items: $items');

      return items ?? [];
    } on DioException catch (e) {
      log(e.message ?? 'Error getting shopping list');
      debugPrint(e.message ?? 'Error getting shopping list', wrapWidth: 1024);
      return [];
    }
  }

  static Future<Item?> addShoppingListItem({
    required String name,
    required double price,
    required int quantity,
    required String code,
  }) async {
    try {
      final response = await dioClient.post(
        '/items',
        data: CreateItemRequest.validated(
          name: name,
          price: price,
          quantity: quantity,
          roomCode: code,
        ).toMap(),
        options: Options(contentType: Headers.jsonContentType),
      );
      log('Got response: $response');
      log('Got response data: ${response.data}');

      final itemRes = switch (response.data) {
        {
          'id': final int id,
          'name': final String name,
          'quantity': final int quantity,
          'price': final double price,
        } =>
          Item.validated(
            id: id,
            name: name,
            quantity: quantity,
            price: price,
            checked: false,
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

  static Future<void> updateItem({
    required int id,
    required bool checked,
    required String code,
  }) async {
    try {
      await dioClient.patch(
        '/items/$id/check',
        data: {
          'checked': checked,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
    } on DioException catch (e) {
      log(e.message ?? 'Error updating item');
      debugPrint(e.message ?? 'Error updating item', wrapWidth: 1024);
    }
  }
}
