final class ItemDB {
  const ItemDB({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.roomId,
    required this.checked,
  });

  factory ItemDB.fromMap(Map<String, dynamic> map) => ItemDB(
        id: map['id'] as int,
        name: map['name'] as String,
        price: map['price'] as double,
        quantity: map['quantity'] as int,
        roomId: map['room_id'] as int,
        checked: map['checked'] as bool,
      );

  final int id;
  final String name;
  final double price;
  final int quantity;
  final int roomId;
  final bool checked;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'quantity': quantity,
        'room_id': roomId,
        'checked': checked,
      };

  static ItemDB? validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {
          'id': final int _,
          'name': final String _,
          'price': final double _,
          'quantity': final int _,
          'room_id': final int _,
          'checked': final bool _,
        } =>
          ItemDB.fromMap(map),
        _ => null,
      };
}
