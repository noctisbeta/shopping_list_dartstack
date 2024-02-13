part of 'items_bloc.dart';

@immutable
sealed class ItemsEvent {
  const ItemsEvent();
}

class GetItems extends ItemsEvent {
  const GetItems();
}

class AddItem extends ItemsEvent {
  const AddItem(this.request);

  final CreateItemRequest request;
}
