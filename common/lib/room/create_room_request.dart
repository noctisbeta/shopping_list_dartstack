final class CreateRoomRequest {
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
}
