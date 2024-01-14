import 'package:dart_frog/dart_frog.dart';

import '../protocols/database_protocol.dart';
import '../services/postgres_service.dart';

Future<DatabaseProtocol>? _database;

Middleware databaseProvider() {
  return provider<Future<DatabaseProtocol>>(
    (_) => _database ??= PostgresService.create(),
  );
}
