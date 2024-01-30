import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/implementations/postgres_service.dart';

PostgresService? _database;

Middleware databaseProvider() => provider<Future<PostgresService>>(
      (_) async => _database ??= await PostgresService.create(),
    );
