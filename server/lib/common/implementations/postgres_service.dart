import 'package:common/exceptions/throws.dart';
import 'package:common/logger/logger.dart';
import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shopping_list_backend/common/exceptions/database_exception.dart';

final class PostgresService {
  PostgresService._(this._conn);

  Connection _conn;

  static Future<PostgresService> create() async {
    try {
      final conn = await _open();

      return PostgresService._(conn);
    } on Exception catch (e) {
      LOG.e('Failed to connect to database: $e');
      rethrow;
    }
  }

  static Future<Connection> _open() async {
    final env = DotEnv(includePlatformEnvironment: true)..load();

    LOG.i('Connecting to database...');

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

  @Throws([DatabaseException])
  Never _rewrapServerException(ServerException e) {
    switch (e.code) {
      case '23505':
        throw DBEuniqueViolation(e.toString());
      default:
        throw DBEunknown(e.toString());
    }
  }

  @Throws([DatabaseException])
  Future<R> runTx<R>(
    Future<R> Function(TxSession sess) fn, {
    TransactionSettings? settings,
  }) async {
    try {
      if (!_conn.isOpen) {
        _conn = await _open();
      }
      return await _conn.runTx(fn, settings: settings);
    } on ServerException catch (e) {
      _rewrapServerException(e);
    } on BadCertificateException catch (e) {
      throw DBEbadCertificate(e.toString());
    }
  }

  @Throws([DatabaseException])
  Future<Result> execute(Sql query, {Map<String, dynamic>? parameters}) async {
    try {
      if (!_conn.isOpen) {
        _conn = await _open();
      }
      return await _conn.execute(query, parameters: parameters);
    } on ServerException catch (e) {
      _rewrapServerException(e);
    } on BadCertificateException catch (e) {
      throw DBEbadCertificate(e.toString());
    }
  }
}
