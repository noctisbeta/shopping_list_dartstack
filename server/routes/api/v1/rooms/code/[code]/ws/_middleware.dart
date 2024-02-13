import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/item/providers/item_data_source_provider.dart';
import 'package:shopping_list_backend/item/providers/item_repository_provider.dart';
import 'package:shopping_list_backend/item/providers/item_socket_handler_provider.dart';

Handler middleware(Handler handler) => handler //
    .use(itemSocketHandlerProvider())
    .use(itemRepositoryProvider())
    .use(itemDataSourceProvider());
