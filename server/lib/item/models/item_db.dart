final class ItemDB {
  const ItemDB({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.roomId,
  });

  factory ItemDB.fromMap(Map<String, dynamic> map) => ItemDB(
        id: map['id'] as int,
        name: map['name'] as String,
        price: map['price'] as double,
        quantity: map['quantity'] as int,
        roomId: map['room_id'] as int,
      );

  final int id;
  final String name;
  final double price;
  final int quantity;
  final int roomId;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'quantity': quantity,
        'room_id': roomId,
      };

  static ItemDB? validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {
          'id': final int _,
          'name': final String _,
          'price': final double _,
          'quantity': final int _,
          'room_id': final int _
        } =>
          ItemDB.fromMap(map),
        _ => null,
      };
}
