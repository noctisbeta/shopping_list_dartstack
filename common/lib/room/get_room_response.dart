import 'package:common/exceptions/response_exception.dart';
import 'package:common/room/room.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class GetRoomResponse extends Equatable {
  const GetRoomResponse._({
    required this.room,
  });

  factory GetRoomResponse._fromMap(Map<String, dynamic> map) =>
      GetRoomResponse._(
        room: Room.validatedFromMap(map['room']),
      );

  final Room room;

  Map<String, dynamic> toMap() => {
        'room': room.toMap(),
      };

  /// Throws [BadResponseBodyException] if [map] has invalid format.
  static GetRoomResponse validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'room': {
            'code': String _,
          }
        } =>
          GetRoomResponse._fromMap(map),
        _ => throw const BadResponseBodyException('Invalid map format')
      };

  @override
  List<Object?> get props => [room];

  @override
  bool get stringify => true;
}
