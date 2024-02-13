import 'package:common/abstractions/json_mappable.dart';
import 'package:common/exceptions/bad_map_shape_exception.dart';
import 'package:common/exceptions/data_validation_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class Item extends Equatable implements MapSerializable {
  Item.validated({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.checked,
  }) {
    if (id < 0) {
      throw const DataValidationException('Invalid id. Must be non-negative');
    }
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
  }

  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool checked;

  @override
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
          Item.validated(
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
