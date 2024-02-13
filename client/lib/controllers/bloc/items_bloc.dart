import 'package:bloc/bloc.dart';
import 'package:common/items/create_item_request.dart';
import 'package:meta/meta.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsInitial()) {
    on<ItemsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  void _handleEvent(ItemsEvent event, Emitter<ItemsState> emit) {
    switch (event) {
      case GetItems():
      // TODO: Handle this case.
      case AddItem():
      // TODO: Handle this case.
    }
  }

  Future<void> _getItems() async {}
}
