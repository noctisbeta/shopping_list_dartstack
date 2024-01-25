import 'package:common/exceptions/bad_request_body_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CreateRoomRequest extends Equatable {
  const CreateRoomRequest({
    required this.code,
  });

  factory CreateRoomRequest._fromMap(Map<String, dynamic> map) =>
      CreateRoomRequest(
        code: map['code'] as String,
      );

  final String code;

  Map<String, dynamic> toMap() => {
        'code': code,
      };

  /// Throws [BadRequestBodyException] if [map] has invalid format.
  static CreateRoomRequest validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {'code': final String _} => CreateRoomRequest._fromMap(map),
        _ => throw const BadRequestBodyException('Invalid map format')
      };

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
