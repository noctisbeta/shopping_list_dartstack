import 'package:common/exceptions/response_exception.dart';
import 'package:common/room/room.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CreateRoomResponse extends Equatable {
  const CreateRoomResponse({
    required this.room,
  });

  factory CreateRoomResponse._fromMap(Map<String, dynamic> map) =>
      CreateRoomResponse(
        room: Room.validatedFromMap(map['room']),
      );

  final Room room;

  Map<String, dynamic> toMap() => {
        'room': room.toMap(),
      };

  /// Throws [BadResponseBodyException] if [map] has invalid format.
  static CreateRoomResponse validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'room': {
            'code': String _,
          }
        } =>
          CreateRoomResponse._fromMap(map),
        _ => throw const BadResponseBodyException('Invalid map format')
      };

  @override
  List<Object?> get props => [room];

  @override
  bool get stringify => true;
}
