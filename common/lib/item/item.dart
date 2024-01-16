import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class Item extends Equatable {
  const Item({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.checked = false,
  });

  factory Item._fromMap(Map<String, dynamic> map) => Item(
        id: map['id'] as int,
        name: map['name'] as String,
        price: map['price'] as double,
        quantity: map['quantity'] as int,
        checked: map['checked'] as bool,
      );

  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool checked;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'quantity': quantity,
        'checked': checked,
      };

  static Item? validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {
          'id': final int _,
          'name': final String _,
          'price': final double _,
          'quantity': final int _,
          'checked': final bool _,
        } =>
          Item._fromMap(map),
        _ => null,
      };

  @override
  List<Object?> get props => [id, name, price, quantity, checked];

  @override
  bool get stringify => true;
}
