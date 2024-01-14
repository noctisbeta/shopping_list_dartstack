enum _Json {
  code,
}

final class Room {
  final String code;

  Room({required this.code});

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      code: map[_Json.code.name] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
    };
  }
}
