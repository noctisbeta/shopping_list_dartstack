import 'package:common/exceptions/request_exception.dart';
import 'package:meta/meta.dart';

@immutable
final class CreateItemRequest {
  const CreateItemRequest._({
    required this.name,
    required this.price,
    required this.quantity,
    required this.roomCode,
  });

  final String name;
  final double price;
  final int quantity;
  final String roomCode;

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
          CreateItemRequest._(
            name: name,
            price: price,
            quantity: quantity,
            roomCode: roomCode,
          ),
        _ => throw const BadRequestBodyException(
            'Invalid map format for CreateItemRequest',
          )
      };
}
