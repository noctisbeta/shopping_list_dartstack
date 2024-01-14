import 'dart:developer';

import 'package:postgres/postgres.dart';

import '../protocols/database_protocol.dart';

final class PostgresService implements DatabaseProtocol {
  const PostgresService._(this._conn);

  final Connection _conn;

  Connection get connection => _conn;

  static Future<PostgresService> create() async {
    try {
      final conn = await Connection.open(
        Endpoint(
          host:
              'ep-misty-union-83632081-pooler.eu-central-1.postgres.vercel-storage.com',
          database: 'verceldb',
          username: 'default',
          password: 'd8vKcokmI0FQ',
        ),
      );
      return PostgresService._(conn);
    } catch (e) {
      log('Error connecting to database: $e');
      rethrow;
    }
  }

  @override
  Future<Result> query(String query) async {
    return _conn.execute(query);
  }
}
