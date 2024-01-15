final class RoomDB {
  RoomDB({
    required this.id,
    required this.code,
  });

  factory RoomDB.fromMap(Map<String, dynamic> map) => RoomDB(
        id: map['id'] as int,
        code: map['code'] as String,
      );

  final int id;
  final String code;

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
      };

  static RoomDB? validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {'id': final int _, 'code': final String _} => RoomDB.fromMap(map),
        _ => null,
      };
}
