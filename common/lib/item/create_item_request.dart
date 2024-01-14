enum _Json {
  label,
  price,
  quantity,
  roomCode,
}

class CreateItemRequest {
  final String label;
  final double price;
  final int quantity;
  final String roomCode;

  const CreateItemRequest({
    required this.label,
    required this.price,
    required this.quantity,
    required this.roomCode,
  });

  Map<String, dynamic> toMap() {
    return {
      _Json.label.name: label,
      _Json.price.name: price,
      _Json.quantity.name: quantity,
      _Json.roomCode.name: roomCode,
    };
  }

  factory CreateItemRequest.fromMap(Map<String, dynamic> map) {
    return CreateItemRequest(
      label: map[_Json.label.name] as String,
      price: map[_Json.price.name] as double,
      quantity: map[_Json.quantity.name] as int,
      roomCode: map[_Json.roomCode.name] as String,
    );
  }
}
