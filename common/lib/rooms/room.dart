import 'package:common/abstractions/json_mappable.dart';
import 'package:common/exceptions/bad_map_shape_exception.dart';
import 'package:common/exceptions/data_validation_exception.dart';
import 'package:common/exceptions/throws.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class Room extends Equatable implements MapSerializable {
  @Throws([DataValidationException])
  Room.validated({required this.code}) {
    if (code.isEmpty || code.length > maxCodeLength) {
      throw const DataValidationException(
        'Invalid room code. Must not be empty or longer than 25 characters',
      );
    }
  }

  final String code;

  static const int maxCodeLength = 25;

  @override
  Map<String, dynamic> toMap() => {
        'code': code,
      };

  @Throws([BadMapShapeException])
  static Room validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {'code': final String code} => Room.validated(code: code),
        _ => throw const BadMapShapeException('Invalid map format for Room'),
      };

  static bool isValidCode(String code) =>
      code.isNotEmpty && code.length <= maxCodeLength;

  @Throws([DataValidationException])
  static void assertValidCode(String code) {
    if (!isValidCode(code)) {
      throw const DataValidationException('Invalid code');
    }
  }

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
