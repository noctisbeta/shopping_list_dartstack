import 'package:bloc/bloc.dart';
import 'package:shopping_list/controllers/bloc/room_event.dart';
import 'package:shopping_list/controllers/bloc/room_state.dart';
import 'package:shopping_list/interfaces/room_repository_protocol.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc(super.initialState, {required RoomRepository repository})
      : _repository = repository {
    on<RoomEvent>(_handleEvent);
  }

  final RoomRepository _repository;

  Future<void> _handleEvent(RoomEvent event, Emitter<RoomState> emit) async {
    switch (event) {
      case CreateRoomEvent():
        await _createRoom(event, emit);
      case EnterRoomEvent():
        await _enterRoom(event, emit);
    }
  }

  Future<void> _createRoom(
    CreateRoomEvent event,
    Emitter<RoomState> emit,
  ) async {
    emit(const RSloading());
    final room = await _repository.createRoom(event.code);
    emit(RScreated(room: room));
  }

  Future<void> _enterRoom(
    EnterRoomEvent event,
    Emitter<RoomState> emit,
  ) async {
    emit(const RSloading());
    final room = await _repository.getRoomByCode(event.code);
    emit(RSentered(room: room));
  }
}
