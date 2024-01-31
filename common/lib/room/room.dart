import 'package:common/exceptions/bad_map_shape_exception.dart';
import 'package:common/exceptions/data_validation_exception.dart';
import 'package:common/exceptions/throws.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class Room extends Equatable {
  const Room._({required this.code});

  @Throws([DataValidationException])
  factory Room.validated({required String code}) {
    if (code.isEmpty || code.length > 25) {
      throw const DataValidationException('Invalid room code');
    }

    return Room._(code: code);
  }

  final String code;

  Map<String, dynamic> toMap() => {
        'code': code,
      };

  @Throws([BadMapShapeException])
  static Room validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {'code': final String code} => Room._(code: code),
        _ => throw const BadMapShapeException('Invalid map format for Room'),
      };

  static bool isValidCode(String code) => code.isNotEmpty && code.length <= 25;

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
