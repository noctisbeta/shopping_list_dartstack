import 'package:equatable/equatable.dart';

final class Item extends Equatable {
  const Item({
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory Item._fromMap(Map<String, dynamic> map) => Item(
        name: map['name'] as String,
        price: map['price'] as double,
        quantity: map['quantity'] as int,
      );

  final String name;
  final double price;
  final int quantity;

  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  static Item? validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {
          'name': final String _,
          'price': final double _,
          'quantity': final int _
        } =>
          Item._fromMap(map),
        _ => null,
      };

  @override
  List<Object?> get props => [name, price, quantity];

  @override
  bool get stringify => true;
}
