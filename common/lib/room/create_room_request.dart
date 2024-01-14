enum _Json {
  code,
}

final class CreateRoomRequest {
  const CreateRoomRequest({
    required this.code,
  });

  final String code;

  factory CreateRoomRequest.fromMap(Map<String, dynamic> map) {
    return CreateRoomRequest(
      code: map[_Json.code.name] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _Json.code.name: code,
    };
  }
}
