import 'package:common/exceptions/bad_map_shape_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class Item extends Equatable {
  const Item._({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.checked,
  });

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

  static Item validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {
          'id': final int id,
          'name': final String name,
          'price': final double price,
          'quantity': final int quantity,
          'checked': final bool checked,
        } =>
          Item._(
            id: id,
            name: name,
            price: price,
            quantity: quantity,
            checked: checked,
          ),
        _ => throw const BadMapShapeException('Invalid map format for Item'),
      };

  @override
  List<Object?> get props => [id, name, price, quantity, checked];

  @override
  bool get stringify => true;
}
