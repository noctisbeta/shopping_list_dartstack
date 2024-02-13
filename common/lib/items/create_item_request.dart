import 'package:common/abstractions/json_mappable.dart';
import 'package:common/exceptions/data_validation_exception.dart';
import 'package:common/exceptions/request_exception.dart';
import 'package:common/rooms/room.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CreateItemRequest extends Equatable implements MapSerializable {
  CreateItemRequest.validated({
    required this.name,
    required this.price,
    required this.quantity,
    required this.roomCode,
  }) {
    if (name.isEmpty) {
      throw const DataValidationException('Invalid name. Must be non-empty');
    }
    if (price < 0) {
      throw const DataValidationException(
        'Invalid price. Must be non-negative',
      );
    }
    if (quantity < 0) {
      throw const DataValidationException(
        'Invalid quantity. Must be non-negative',
      );
    }
    if (roomCode.isEmpty || roomCode.length > Room.maxCodeLength) {
      throw const DataValidationException(
        'Invalid room code. Must be non-empty',
      );
    }
  }

  final String name;
  final double price;
  final int quantity;
  final String roomCode;

  @override
  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
        'quantity': quantity,
        'roomCode': roomCode,
      };

  static CreateItemRequest validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'name': final String name,
          'price': final double price,
          'quantity': final int quantity,
          'roomCode': final String roomCode,
        } =>
          CreateItemRequest.validated(
            name: name,
            price: price,
            quantity: quantity,
            roomCode: roomCode,
          ),
        _ => throw const BadRequestBodyException(
            'Invalid map format for CreateItemRequest',
          )
      };

  @override
  List<Object?> get props => [name, price, quantity, roomCode];

  @override
  bool get stringify => true;
}
