import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/implementations/migration_service.dart';
import 'package:shopping_list_backend/common/implementations/postgres_service.dart';

Future<void> init(InternetAddress ip, int port) async {
  final database = await PostgresService.create();
  final migrationService = MigrationService(db: database);

  await migrationService.up();
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async =>
    serve(handler, ip, port);
