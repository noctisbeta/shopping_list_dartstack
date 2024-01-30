import 'package:common/logger/logger.dart';
import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shopping_list_backend/common/exceptions/database_exception.dart';

final class PostgresService {
  PostgresService._(this._conn);

  Connection _conn;

  static Future<PostgresService> create() async {
    try {
      final conn = await open();

      return PostgresService._(conn);
    } on Exception catch (e) {
      LOG.e('Failed to connect to database: $e');
      rethrow;
    }
  }

  static Future<Connection> open() async {
    final env = DotEnv(includePlatformEnvironment: true)..load();

    final conn = await Connection.open(
      Endpoint(
        host: env['POSTGRES_HOST']!,
        database: env['POSTGRES_DATABASE']!,
        username: env['POSTGRES_USER'],
        password: env['POSTGRES_PASSWORD'],
      ),
    );

    return conn;
  }

  Future<R> runTx<R>(
    Future<R> Function(TxSession sess) fn, {
    TransactionSettings? settings,
  }) async {
    try {
      if (!_conn.isOpen) {
        _conn = await open();
      }
      return await _conn.runTx(fn, settings: settings);
    } on ServerException catch (e) {
      switch (e.code) {
        case '23505':
          throw DatabaseUniqueViolationException(e.toString());
        default:
          throw DatabaseUnknownException(e.toString());
      }
    } on BadCertificateException catch (e) {
      throw DatabaseBadCertificateException(e.toString());
    } on Exception {
      rethrow;
    }
  }

  Future<Result> execute(Sql query, {Map<String, dynamic>? parameters}) async {
    try {
      if (!_conn.isOpen) {
        _conn = await open();
      }
      return await _conn.execute(query, parameters: parameters);
    } on ServerException catch (e) {
      switch (e.code) {
        case '23505':
          throw DatabaseUniqueViolationException(e.toString());
        default:
          throw DatabaseUnknownException(e.toString());
      }
    } on BadCertificateException catch (e) {
      throw DatabaseBadCertificateException(e.toString());
    } on Exception {
      rethrow;
    }
  }
}
