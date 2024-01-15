import 'package:postgres/postgres.dart';

abstract interface class DatabaseProtocol {
  Future<Result> query(String query);
  Connection get connection;
}
