import 'package:common/exceptions/request_Exception.dart';
import 'package:common/exceptions/throws.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CreateRoomRequest extends Equatable {
  const CreateRoomRequest._({
    required this.code,
  });

  final String code;

  Map<String, dynamic> toMap() => {
        'code': code,
      };

  @Throws([BadRequestBodyException])
  static CreateRoomRequest validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {'code': final String code} => CreateRoomRequest._(code: code),
        _ => throw const BadRequestBodyException(
            'Invalid map format for CreateRoomRequest',
          )
      };

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
