import 'package:common/abstractions/json_mappable.dart';
import 'package:common/exceptions/request_Exception.dart';
import 'package:common/rooms/room.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class GetRoomRequest extends Equatable implements MapSerializable {
  GetRoomRequest.validated({
    required this.code,
  }) {
    if (code.isEmpty || code.length > Room.maxCodeLength) {
      throw const BadRequestBodyException(
        'Code must be between 1 and 25 chars',
      );
    }
  }

  final String code;

  @override
  Map<String, dynamic> toMap() => {
        'code': code,
      };

  static GetRoomRequest validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'code': final String code,
        } =>
          GetRoomRequest.validated(code: code),
        _ => throw const BadRequestBodyException('Invalid map format')
      };

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
