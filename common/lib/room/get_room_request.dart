import 'package:common/exceptions/request_Exception.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class GetRoomRequest extends Equatable {
  const GetRoomRequest._({
    required this.code,
  });

  final String code;

  Map<String, dynamic> toMap() => {
        'code': code,
      };

  static GetRoomRequest validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'code': final String code,
        } =>
          GetRoomRequest._(code: code),
        _ => throw const BadRequestBodyException('Invalid map format')
      };

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
