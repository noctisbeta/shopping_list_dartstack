import 'package:dart_frog/dart_frog.dart';

import '../implemenations/item_handler.dart';
import '../protocols/item_handler_protocol.dart';
import '../protocols/item_service_protocol.dart';

ItemHandlerProtocol? _itemHandler;

Middleware roomHandlerProvider() {
  return provider<ItemHandlerProtocol>(
    (ctx) => _itemHandler ??= ItemHandler(
      roomService: ctx.read<ItemServiceProtocol>(),
    ),
  );
}
