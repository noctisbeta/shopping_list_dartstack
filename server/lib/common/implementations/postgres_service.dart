import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shopping_list_backend/common/protocols/database_protocol.dart';

final class PostgresService implements DatabaseProtocol {
  const PostgresService._(this._conn);

  final Connection _conn;

  @override
  Connection get connection => _conn;

  static Future<PostgresService> create() async {
    final env = DotEnv(includePlatformEnvironment: true)..load();

    try {
      final conn = await Connection.open(
        Endpoint(
          host: env['POSTGRES_HOST']!,
          database: env['POSTGRES_DATABASE']!,
          username: env['POSTGRES_USER'],
          password: env['POSTGRES_PASSWORD'],
        ),
      );
      return PostgresService._(conn);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Result> query(String query) async => _conn.execute(query);
}