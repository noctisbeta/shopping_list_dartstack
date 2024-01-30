import 'package:common/exceptions/bad_map_shape_exception.dart';
import 'package:common/exceptions/throws.dart';
import 'package:common/exceptions/validated_model_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class Room extends Equatable {
  const Room._({required this.code});

  factory Room._fromMap(Map<String, dynamic> map) => Room._(
        code: map['code'] as String,
      );

  factory Room.validated({required String code}) {
    if (code.isEmpty || code.length > 25) {
      throw const BadMapShapeException('Invalid code');
    }

    return Room._(code: code);
  }

  final String code;

  Map<String, dynamic> toMap() => {
        'code': code,
      };

  static Room validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {'code': String _} => Room._fromMap(map),
        _ => throw const BadMapShapeException('Invalid map format'),
      };

  static bool isValidCode(String code) => code.isNotEmpty && code.length <= 25;

  @Throws([ValidatedModelException])
  static void assertValidCode(String code) {
    if (!isValidCode(code)) {
      throw const ValidatedModelException('Invalid code');
    }
  }

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
