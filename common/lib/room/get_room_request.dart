import 'package:common/exceptions/request_Exception.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class GetRoomRequest extends Equatable {
  const GetRoomRequest._({
    required this.code,
  });

  factory GetRoomRequest._fromMap(Map<String, dynamic> map) => GetRoomRequest._(
        code: (map['room'] as Map<String, dynamic>)['code'] as String,
      );

  final String code;

  Map<String, dynamic> toMap() => {
        'code': code,
      };

  /// Throws [BadRequestBodyException] if [map] has invalid format.
  static GetRoomRequest validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'code': final String _,
        } =>
          GetRoomRequest._fromMap(map),
        _ => throw const BadRequestBodyException('Invalid map format')
      };

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
