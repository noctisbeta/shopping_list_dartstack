import 'package:dart_frog/dart_frog.dart';

abstract interface class RoomHandlerProtocol {
  Future<Response> createRoom(RequestContext context);
  Future<Response> getRoomByCode(String code);
}
