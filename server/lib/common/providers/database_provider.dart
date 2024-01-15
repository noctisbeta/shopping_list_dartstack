import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/implementations/postgres_service.dart';
import 'package:shopping_list_backend/common/protocols/database_protocol.dart';

DatabaseProtocol? _database;

Middleware databaseProvider() => provider<Future<DatabaseProtocol>>(
      (_) async => _database ??= await PostgresService.create(),
    );
