import 'package:meta/meta.dart';

@immutable
final class CreateItemRequest {
  const CreateItemRequest({
    required this.name,
    required this.price,
    required this.quantity,
    required this.roomCode,
  });

  factory CreateItemRequest._fromMap(Map<String, dynamic> map) =>
      CreateItemRequest(
        name: map['name'] as String,
        price: map['price'] as double,
        quantity: map['quantity'] as int,
        roomCode: map['roomCode'] as String,
      );

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

  static CreateItemRequest? validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'name': final String _,
          'price': final double _,
          'quantity': final int _,
          'roomCode': final String _
        } =>
          CreateItemRequest._fromMap(map),
        _ => null,
      };
}
