import 'package:common/exceptions/response_exception.dart';
import 'package:common/exceptions/throws.dart';
import 'package:common/room/room.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CreateRoomResponse extends Equatable {
  const CreateRoomResponse._({
    required this.room,
  });

  final Room room;

  Map<String, dynamic> toMap() => {
        'room': room.toMap(),
      };

  @Throws([BadResponseBodyException])
  static CreateRoomResponse validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'room': {
            'code': final String code,
          }
        } =>
          CreateRoomResponse._(
            room: Room.validated(code: code),
          ),
        _ => throw const BadResponseBodyException(
            'Invalid map format for CreateRoomResponse',
          )
      };

  @override
  List<Object?> get props => [room];

  @override
  bool get stringify => true;
}
