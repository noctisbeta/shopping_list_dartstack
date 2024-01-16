import 'dart:io';

import 'package:common/item/check_item_request.dart';
import 'package:common/item/create_item_request.dart';
import 'package:postgres/postgres.dart';
import 'package:shopping_list_backend/common/protocols/database_protocol.dart';
import 'package:shopping_list_backend/item/models/item_db.dart';
import 'package:shopping_list_backend/item/protocols/item_repository_protocol.dart';
import 'package:shopping_list_backend/room/models/room_db.dart';

final class ItemRepository implements ItemRepositoryProtocol {
  const ItemRepository({
    required DatabaseProtocol database,
  }) : _database = database;

  final DatabaseProtocol _database;

  @override
  Future<ItemDB> createItem(CreateItemRequest request) {
    try {
      return _database.connection.runTx(
        (s) async {
          final res = await s.execute(
            Sql.named('SELECT * FROM rooms WHERE code = @code'),
            parameters: {'code': request.roomCode},
          );

          final roomDB = RoomDB.validatedFromMap(res.first.toColumnMap());

          if (roomDB == null) {
            throw Exception('Room not found');
          }

          final res2 = await s.execute(
            Sql.named(
              'INSERT INTO items (name, price, quantity, room_id) VALUES '
              '(@name, @price, @quantity, @room_id) RETURNING *',
            ),
            parameters: {
              'name': request.name,
              'price': request.price,
              'quantity': request.quantity,
              'room_id': roomDB.id,
            },
          );

          final itemDb = ItemDB.validatedFromMap(res2.first.toColumnMap());

          if (itemDb == null) {
            throw Exception('Item not created');
          }

          return itemDb;
        },
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<ItemDB>> getItems(String code) async {
    stdout.writeln('ItemRepository.getItems');
    try {
      return await _database.connection.runTx(
        (s) async {
          final res = await s.execute(
            Sql.named('SELECT * FROM rooms WHERE code = @code'),
            parameters: {'code': code},
          );

          stdout.writeln(res);

          final roomDB = RoomDB.validatedFromMap(res.first.toColumnMap());

          if (roomDB == null) {
            throw Exception('Room not found');
          }

          final res2 = await s.execute(
            Sql.named('SELECT * FROM items WHERE room_id = @room_id'),
            parameters: {'room_id': roomDB.id},
          );

          final items =
              res2.map((e) => ItemDB.validatedFromMap(e.toColumnMap()));

          if (items.contains(null)) {
            throw Exception('Item not found');
          }

          return items.map((e) => e!).toList();
        },
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ItemDB> checkItem(CheckItemRequest request) async {
    try {
      return await _database.connection.runTx(
        (s) async {
          final res2 = await s.execute(
            Sql.named(
              'UPDATE items SET checked = @checked WHERE id = @id'
              ' AND checked = @notChecked RETURNING *',
            ),
            parameters: {
              'id': request.id,
              'checked': request.checked,
              'notChecked': !request.checked,
            },
          );

          final itemDb = ItemDB.validatedFromMap(res2.first.toColumnMap());

          if (itemDb == null) {
            throw Exception('Item not updated');
          }

          return itemDb;
        },
      );
    } on Exception {
      rethrow;
    }
  }
}
