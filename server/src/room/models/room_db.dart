final class RoomDB {
  RoomDB({
    required this.id,
    required this.code,
  });

  factory RoomDB.fromMap(Map<String, dynamic> map) {
    return RoomDB(
      id: map['id'] as int,
      code: map['code'] as String,
    );
  }

  final int id;
  final String code;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
    };
  }
}
