import 'package:common/exceptions/throws.dart';
import 'package:shopping_list_backend/common/exceptions/database_exception.dart';

final class RoomDB {
  RoomDB._({
    required this.id,
    required this.code,
  });

  final int id;
  final String code;

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
      };

  @Throws([DBEbadSchema])
  static RoomDB validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {
          'id': final int id,
          'code': final String code,
        } =>
          RoomDB._(
            id: id,
            code: code,
          ),
        _ => throw const DBEbadSchema('Map has invalid format for RoomDB'),
      };
}
