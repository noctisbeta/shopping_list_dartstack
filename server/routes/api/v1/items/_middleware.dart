import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/item/providers/item_data_source_provider.dart';
import 'package:shopping_list_backend/item/providers/item_handler_provider.dart';
import 'package:shopping_list_backend/item/providers/item_repository_provider.dart';

Handler middleware(Handler handler) => handler
    .use(itemHandlerProvider())
    .use(itemRepositoryProvider())
    .use(itemDataSourceProvider());
