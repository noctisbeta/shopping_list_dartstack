import 'package:common/exceptions/bad_request_body_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class Room extends Equatable {
  const Room({required this.code});

  factory Room._fromMap(Map<String, dynamic> map) => Room(
        code: map['code'] as String,
      );

  final String code;

  Map<String, dynamic> toMap() => {
        'code': code,
      };

  static Room validatedFromMap(Map<String, dynamic> map) => switch (map) {
        {'code': String _} => Room._fromMap(map),
        _ => throw const BadRequestBodyException('Invalid map format'),
      };

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
