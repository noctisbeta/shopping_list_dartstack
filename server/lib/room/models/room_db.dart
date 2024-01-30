import 'package:common/exceptions/throws.dart';
import 'package:shopping_list_backend/common/exceptions/database_exception.dart';

final class RoomDB {
  RoomDB({
    required this.id,
    required this.code,
  });

  factory RoomDB._fromMap(Map<String, dynamic> map) => RoomDB(
        id: map['id'] as int,
        code: map['code'] as String,
      );

  final int id;
  final String code;

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
      };

  @Throws([DatabaseSchemaException])
  static RoomDB validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {'id': int _, 'code': String _} => RoomDB._fromMap(map),
        _ => throw const DatabaseSchemaException('Invalid database schema'),
      };
}
