import 'package:dart_frog/dart_frog.dart';

abstract interface class RoomHandlerProtocol {
  Future<Response> createRoom(RequestContext context);
  Future<Response> getRoomByCode(RequestContext context, String code);
  Future<Response> getRoomItems(RequestContext context, String code);
}
