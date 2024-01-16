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

  static CreateRoomRequest? validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {'code': final String _} => CreateRoomRequest._fromMap(map),
        _ => null,
      };

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}
