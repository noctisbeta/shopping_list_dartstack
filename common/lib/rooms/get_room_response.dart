import 'package:common/abstractions/json_mappable.dart';
import 'package:common/exceptions/data_validation_exception.dart';
import 'package:common/exceptions/response_exception.dart';
import 'package:common/exceptions/throws.dart';
import 'package:common/rooms/room.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class GetRoomResponse extends Equatable implements MapSerializable {
  GetRoomResponse.validated({
    required this.room,
  }) {
    if (room.code.isEmpty || room.code.length > Room.maxCodeLength) {
      throw const DataValidationException(
        'Invalid room code. Must not be empty or longer than 25 characters',
      );
    }
  }

  final Room room;

  @override
  Map<String, dynamic> toMap() => {
        'room': room.toMap(),
      };

  @Throws([BadResponseBodyException])
  static GetRoomResponse validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'room': {
            'code': final String code,
          }
        } =>
          GetRoomResponse.validated(
            room: Room.validated(code: code),
          ),
        _ => throw const BadResponseBodyException(
            'Invalid map format for GetRoomResponse',
          )
      };

  @override
  List<Object?> get props => [room];

  @override
  bool get stringify => true;
}
