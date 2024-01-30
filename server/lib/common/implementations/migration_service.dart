import 'package:shopping_list_backend/common/implementations/postgres_service.dart';
import 'package:shopping_list_backend/common/models/migration.dart';
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
  const Migration(
    order: 3,
    up: '''
    ALTER TABLE IF EXISTS items ADD COLUMN IF NOT EXISTS checked BOOLEAN NOT NULL DEFAULT FALSE;
    ''',
    down: '''
    ALTER TABLE IF EXISTS items DROP COLUMN IF EXISTS checked;
    ''',
  ),
]..sort((m, n) => m.order.compareTo(n.order));

final class MigrationService implements MigrationProtocol {
  MigrationService({
    required PostgresService db,
  }) : _db = db;

  final PostgresService _db;

  @override
  Future<void> up({int? count}) async {
    final amount = count ?? _migrations.length;

    await _db.runTx((session) {
      final results = <Future>[];

      for (final m in _migrations.take(amount)) {
        results.add(session.execute(m.up));
      }

      return Future.wait(results);
    });
  }

  @override
  Future<void> down({int? count}) async {
    final amount = count ?? _migrations.length;

    await _db.runTx((session) {
      final results = <Future>[];

      for (final m in _migrations.reversed.take(amount)) {
        results.add(session.execute(m.down));
      }

      return Future.wait(results);
    });
  }
}
