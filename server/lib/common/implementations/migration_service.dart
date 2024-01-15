import 'package:logger/logger.dart';
import 'package:shopping_list_backend/common/models/migration.dart';
import 'package:shopping_list_backend/common/protocols/database_protocol.dart';
import 'package:shopping_list_backend/common/protocols/migration_protocol.dart';

final _migrations = [
  const Migration(
    order: 1,
    up: '''
    CREATE TABLE IF NOT EXISTS rooms (
      id SERIAL PRIMARY KEY NOT NULL,
      code VARCHAR(25) NOT NULL UNIQUE
    );
    ''',
    down: '''
    DROP TABLE IF EXISTS rooms;
    ''',
  ),
  const Migration(
    order: 2,
    up: '''
    CREATE TABLE IF NOT EXISTS items (
      id SERIAL PRIMARY KEY NOT NULL,
      name VARCHAR(50) NOT NULL,
      price FLOAT NOT NULL,
      quantity INTEGER NOT NULL,
      room_id INTEGER NOT NULL REFERENCES rooms(id)
    );
    ''',
    down: '''
    DROP TABLE IF EXISTS items;
    ''',
  ),
]..sort((m, n) => m.order.compareTo(n.order));

final class MigrationService implements MigrationProtocol {
  MigrationService({
    required DatabaseProtocol db,
  }) : _db = db;

  final DatabaseProtocol _db;

  @override
  Future<void> up({int? count}) async {
    final amount = count ?? _migrations.length;

    await _db.connection.runTx((session) {
      final results = <Future>[];

      for (final m in _migrations.take(amount)) {
        Logger().d(m.up);
        results.add(session.execute(m.up));
      }

      return Future.wait(results);
    });
  }

  @override
  Future<void> down({int? count}) async {
    final amount = count ?? _migrations.length;

    await _db.connection.runTx((session) {
      final results = <Future>[];

      for (final m in _migrations.reversed.take(amount)) {
        results.add(session.execute(m.down));
      }

      return Future.wait(results);
    });
  }
}
