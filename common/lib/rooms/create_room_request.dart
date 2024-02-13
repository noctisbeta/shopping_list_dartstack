import 'package:common/abstractions/json_mappable.dart';
import 'package:common/exceptions/request_Exception.dart';
import 'package:common/exceptions/throws.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CreateRoomRequest extends Equatable implements MapSerializable {
  CreateRoomRequest.validated({
    required this.code,
  }) {
    if (code.isEmpty || code.length > 25) {
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

  @Throws([BadRequestBodyException])
  static CreateRoomRequest validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {'code': final String code} => CreateRoomRequest.validated(code: code),
        _ => throw const BadRequestBodyException(
            'Invalid map format for CreateRoomRequest',
          )
      };

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
